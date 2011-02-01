class Score < ActiveRecord::Base
  
  has_one :user
  has_one :match
  
  validate :only_2_scores_per_match,
           :all_different_users_per_match
  validates_presence_of :score
  
  after_save :update_membership_won_matches
  after_save :update_membership_played_matches
  after_save :update_membership_won_games
  after_save :update_membership_played_games
  
  def update_membership_won_matches
    highest_score = nil
    match = Match.find(self.match_id)
    if match.scores.count > 1
      match.scores.each do |score|
        highest_score = score if highest_score.nil? or score.score > highest_score.score
      end
      membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, highest_score.user_id])
      membership.won_matches += 1
      membership.update_attributes(membership)
    end
  end
  
  def update_membership_played_matches
    match = Match.find(self.match_id)
    membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, self.user_id])
    membership.played_matches += 1
    membership.update_attributes(membership)
  end
  
  def update_membership_won_games
    match = Match.find(self.match_id)
    membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, self.user_id])
    membership.won_games += self.score
    membership.update_attributes(membership)
  end
  
  def update_membership_played_games
    match = Match.find(self.match_id)
    if match.scores.count > 1
      total_match_games = 0
      match.scores.each do |score|
        total_match_games += score.score
      end
      match.scores.each do |score|
        membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, score.user_id])
        membership.played_games += total_match_games
        membership.update_attributes(membership)
      end
    end
  end
  
private

  def only_2_scores_per_match
    errors.add(:only_2_scores_per_match, "can only have 2 scores") if Match.find(self.match_id).scores.length >= 2
  end
  
  def all_different_users_per_match
    first_score = Match.find(self.match_id).scores[0]
    errors.add(:all_different_users_per_match, "can not use the same user twice") if !first_score.nil? and first_score.user_id == self.user_id
  end
  
end
