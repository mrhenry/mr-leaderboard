class Membership < ActiveRecord::Base
  
  belongs_to :leaderboard
  belongs_to :user
  
  default_scope order('won_matches DESC')
  
  def reset
    self.won_matches    = 0
    self.played_matches = 0
    self.played_games   = 0
    self.won_games      = 0
    self.update_attributes(self)
  end
  
  def match_win_percentage
    return (Float(self.won_matches) / Float(self.played_matches) * 100).round(2)
  end
  
  def game_win_percentage
    return (Float(self.won_games) / Float(self.played_games) * 100).round(2)
  end
  
end
