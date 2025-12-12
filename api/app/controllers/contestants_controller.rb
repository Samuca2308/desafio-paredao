class ContestantsController < ApplicationController
  def names
    contestants = Contestant.select(:id, :name)
    render json: contestants, only: [:id, :name], status: :ok
  end
end