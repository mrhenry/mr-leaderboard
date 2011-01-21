class Game < ActiveRecord::Base
  
  has_one :leaderboard
  has_many :users
  
end
