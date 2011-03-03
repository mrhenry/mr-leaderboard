class Score < ActiveRecord::Base
  
  has_one :membership
  has_one :match
  
  validate :only_2_scores_per_match,
           :all_different_users_per_match
  validates_presence_of :score
  
  after_save :save_match
  
  def save_match
    Match.find(self.match_id).save
  end
  
private

  def only_2_scores_per_match
    errors.add(:only_2_scores_per_match, "can only have 2 scores") if Match.find(self.match_id).scores.length >= 2
  end
  
  def all_different_users_per_match
    first_score = Match.find(self.match_id).scores[0]
    errors.add(:all_different_users_per_match, "can not use the same user twice") if !first_score.nil? and first_score.membership_id == self.membership_id
  end
  
end
