class Score < ActiveRecord::Base
  
  has_one :user
  has_one :match
  
  validate :only_2_scores_per_match,
           :all_different_users_per_match
  validates_presence_of :score
  
  #after_save :update_memberships
  
  after_save :update_membership_won_games
  
private

  def only_2_scores_per_match
    errors.add(:only_2_scores_per_match, "can only have 2 scores") if Match.find(self.match_id).scores.length >= 2
  end
  
  def all_different_users_per_match
    first_score = Match.find(self.match_id).scores[0]
    errors.add(:all_different_users_per_match, "can not use the same user twice") if !first_score.nil? and first_score.user_id == self.user_id
  end
  
  def update_memberships
    #match           = Match.find(self.match_id)
    #leaderboard     = Leaderboard.find(match.leaderboard_id)
    #match.scores.each do |current_score|
    #  membership      = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', leaderboard.id, current_score.user_id])
    #  won_games       = 0
    #  games_per_match = 0
    #  played_games    = 0
    #  participated    = false
    #  leaderboard.matches.each_with_index do |match, match_idx|
    #    match.scores.each_with_index do |score, score_idx|
    #      if match_idx > 0
    #        if score_idx == 0
    #          if participated
    #            played_games += games_per_match
    #            participated = false
    #          end
    #          games_per_match = 0
    #        end
    #      end
    #      if (score.user_id == current_score.user_id)
    #        won_games += score.score
    #        participated = true
    #      end
    #      games_per_match += score.score
    #    end
    #  end
    #  if participated
    #    played_games += games_per_match
    #  end
    #  membership.played_games = played_games
    #  membership.won_games    = won_games
    #  membership.update_attributes(membership)
    #end
  end
  
  def update_membership_won_games
    match       = Match.find(self.match_id)
    membership  = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, self.user_id])
    membership.won_games += self.score
    membership.update_attributes(membership)
  end
  
  
end
