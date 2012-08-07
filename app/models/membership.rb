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

  def won_matches_in_period(leaderboard, time = Time.now)
    won_matches = 0
    matches     = leaderboard.matches.select { |match| match.created_at <= time.end_of_month() and match.created_at >= time.beginning_of_month() }
    matches.each do |match|
      won_matches += 1 if (match.scores.sort {|a,b| a.score <=> b.score }).last.membership_id == self.id
    end
    won_matches
  end

end
