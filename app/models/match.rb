class Match < ActiveRecord::Base
  
  default_scope :order => 'created_at DESC'
  
  has_one :leaderboard
  has_many :scores, :dependent => :destroy
  
  after_save :add_membership_statistics
  
  before_destroy :subtract_membership_statistics
  
  def add_membership_statistics
    return if self.scores.count < 2
    self.scores.each do |score|
      membership = Membership.first(:conditions => ["id = ?", score.membership_id]) || find_membership_by_user_id(score, self.leaderboard_id)
      membership.played_games   += self.scores[0].score + self.scores[1].score
      membership.played_matches += 1
      membership.won_games      += score.score
      membership.won_matches    += 1 if (self.scores.sort {|a,b| a.score <=> b.score }).last.membership_id == score.membership_id
      membership.update_attributes(membership)
    end
  end
  
  def subtract_membership_statistics
    self.scores.each do |score|
      membership = Membership.first(:conditions => ["id = ?", score.membership_id])
      membership.played_games   -= self.scores[0].score + (self.scores[1].score rescue 0)
      membership.played_matches -= 1
      membership.won_games      -= score.score
      membership.won_matches    -= 1 if (self.scores.sort {|a,b| a.score <=> b.score }).last.membership_id == score.membership_id
      membership.update_attributes(membership)
    end
  end
  
private
  
  def find_membership_by_user_id(score, leaderboard_id)
    membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", leaderboard_id, score.user_id])
    
    score.membership_id = membership.id
    if score.update_attributes!(score)
      Rails.logger.debug('---------------')
      Rails.logger.debug("saved")
      Rails.logger.debug('---------------')
    else
      Rails.logger.debug('---------------')
      Rails.logger.debug(errors.inspect)
      Rails.logger.debug("not saved")
      Rails.logger.debug(score.inspect)
      Rails.logger.debug('---------------')
    end
    
    return membership
  end
  
end
