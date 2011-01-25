module LeaderboardsHelper
  
  def membership_score(user)
    unless user.nil?
      membership = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', @leaderboard.id, user.id])
      membership.score
    end
  end
  
end
