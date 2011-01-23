class Game < ActiveRecord::Base
  
  default_scope :order => 'created_at DESC'
  
  has_one :leaderboard
  has_many :scores
  
end
