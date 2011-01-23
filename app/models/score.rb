class Score < ActiveRecord::Base
  
  has_one :user
  has_one :game
  
  validate :only_2_scores_per_game,
           :all_different_users_per_game
  validates_presence_of :score
  
private

  def only_2_scores_per_game
    errors.add(:only_2_scores_per_game, "can only have 2 scores") if Game.find(self.game_id).scores.length >= 2
  end
  
  def all_different_users_per_game
    first_score = Game.find(self.game_id).scores[0]
    errors.add(:all_different_users_per_game, "can not use the same user twice") if !first_score.nil? and first_score.user_id == self.user_id
  end
  
end
