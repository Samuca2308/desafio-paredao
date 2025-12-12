class DashboardController < ApplicationController
  def index
    @total_votes = Contestant.joins(:votes)
                             .group(:id)
                             .select('contestants.id, contestants.name, COUNT(votes.id) as vote_count')
    puts "Total Votes: #{@total_votes.inspect}"

    @votes_by_hour = Vote.where('created_at > ?', 24.hours.ago)
                         .group_by_hour(:created_at)
                         .count
    puts "Votes by Hour: #{@votes_by_hour.inspect}"

    total_votes = Vote.count
    @vote_percentages = Contestant.joins(:votes)
                                  .group(:id)
                                  .select('contestants.id, contestants.name, COUNT(votes.id) as vote_count')
                                  .map do |contestant|
                                    {
                                      name: contestant.name,
                                      percentage: total_votes.zero? ? 0 : (contestant.vote_count.to_f / total_votes) * 100
                                    }
                                  end
    puts "Vote Percentages: #{@vote_percentages.inspect}"

    sample_ip_address = '192.168.1.1'  # IP mockado
    @rate_limit_status = RateLimiter.status(sample_ip_address) || {
      exceeded: false,
      remaining: 5,
      exceeded_count: 0
    }
  end
end
