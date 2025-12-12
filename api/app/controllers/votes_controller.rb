class VotesController < ApplicationController
  protect_from_forgery with: :null_session, only: [:create]
  before_action :check_rate_limit, only: [:create]

  def create
    vote_session = VoteSession.find_or_create_by(ip_address: request.remote_ip)
    # return render json: { error: 'Already voted' }, status: :unprocessable_entity if vote_session.votes.exists?

    contestant = Contestant.find(params[:contestant_id])
    vote_session.votes.create!(contestant: contestant)

    render json: { message: 'Vote cast successfully' }, status: :created
  end

  def total
    total_votes = Rails.cache.fetch('total_votes') do
      Contestant.joins(:votes)
                .group(:id)
                .select('contestants.id, contestants.name, COUNT(votes.id) as vote_count')
    end

    render json: total_votes, status: :ok
  end

  def total_by_hour
    start_time = 1.hour.ago.beginning_of_hour
    end_time = Time.now.beginning_of_hour
    total_votes = Vote.where(created_at: start_time..end_time)
                      .group("DATE_TRUNC('hour', votes.created_at)")
                      .count

    render json: total_votes, status: :ok
  end

  def current_percentage
    total_votes = Rails.cache.fetch('total_votes_count') { Vote.count }
    contestant_votes = Rails.cache.fetch('contestant_votes') do
      Contestant.joins(:votes)
                .group(:id)
                .select('contestants.id, COUNT(votes.id) as vote_count')
    end

    percentages = contestant_votes.map do |contestant|
      {
        name: contestant.name,
        percentage: total_votes.zero? ? 0 : (contestant.vote_count.to_f / total_votes) * 100
      }
    end

    render json: percentages, status: :ok
  end

  private

  def check_rate_limit
    if RateLimiter.exceeded?(request.remote_ip)
      render json: { error: 'Rate limit exceeded' }, status: :too_many_requests
    end
  end
end
