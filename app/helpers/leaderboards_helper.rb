module LeaderboardsHelper
  
  def membership_won_matches(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.won_matches
    end
  end
  
  def membership_played_matches(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.played_matches
    end
  end
  
  def membership_won_games(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.won_games
    end
  end
  
  def membership_played_games(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.played_games
    end
  end
  
  def membership_games_win_percentage(user)
    unless user.nil?
      (Float(membership_won_games(user)) / Float(membership_played_games(user)) * 100).round
    end
  end
  
end
