module LeaderboardsHelper
  
  def membership_score(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.score
    end
  end
  
  def membership_played_sets(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.played_sets
    end
  end
  
  def user_played_sets_win_percentage(user)
    unless user.nil?
      (Float(membership_score(user)) / Float(membership_played_sets(user)) * 100).round
    end
  end
  
end
