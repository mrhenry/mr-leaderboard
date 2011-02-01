class Membership < ActiveRecord::Base
  
  belongs_to :leaderboard
  belongs_to :user
  
  def reset
    self.won_matches    = 0
    self.played_matches = 0
    self.played_games   = 0
    self.won_games      = 0
    self.update_attributes(self)
  end
  
end
