class Match < ActiveRecord::Base
  
  default_scope :order => 'created_at DESC'
  
  has_one :leaderboard
  has_many :scores
  
  before_destroy :update_membership_won_games
  
private

  def update_membership_won_games
    self.scores.each do |score|
      membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", self.leaderboard_id, score.user_id])
      membership.won_games -= score.score
      membership.update_attributes(membership)
    end
  end
  
end
