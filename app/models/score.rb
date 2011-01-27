class Score < ActiveRecord::Base
  
  has_one :user
  has_one :match
  
  validate :only_2_scores_per_match,
           :all_different_users_per_match
  validates_presence_of :score
  
  after_save :update_membership
  
private

  def only_2_scores_per_match
    errors.add(:only_2_scores_per_match, "can only have 2 scores") if Match.find(self.match_id).scores.length >= 2
  end
  
  def all_different_users_per_match
    first_score = Match.find(self.match_id).scores[0]
    errors.add(:all_different_users_per_match, "can not use the same user twice") if !first_score.nil? and first_score.user_id == self.user_id
  end
  
  def update_membership
    match           = Match.find(self.match_id)
    leaderboard     = Leaderboard.find(match.leaderboard_id)
    membership      = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', leaderboard.id, self.user_id])
    total_score     = 0
    sets_per_match  = 0
    played_sets     = 0
    participated    = false
    leaderboard.matches.each_with_index do |match, match_idx|
      match.scores.each_with_index do |score, score_idx|
        if match_idx > 0
          if score_idx == 0
            if participated
              played_sets += sets_per_match
              participated = false
            end
            sets_per_match = 0
          end
        end
        if (score.user_id == self.user_id)
          total_score += score.score
          participated = true
        end
        sets_per_match += score.score
      end
    end
    if participated
      played_sets += sets_per_match
    end
    membership.played_sets = played_sets
    membership.score       = total_score
    membership.update_attributes(membership)
  end
  
end
