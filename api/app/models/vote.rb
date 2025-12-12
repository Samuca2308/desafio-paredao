class Vote < ApplicationRecord
  belongs_to :contestant
  belongs_to :vote_session
end