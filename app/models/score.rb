class Score < ActiveRecord::Base
  
  has_one :user
  has_one :game
  
  validate :only_2_scores_per_game,
           :all_different_users_per_game
  validates_presence_of :score
  
  after_save :update_membership
  
private

  def only_2_scores_per_game
    errors.add(:only_2_scores_per_game, "can only have 2 scores") if Game.find(self.game_id).scores.length >= 2
  end
  
  def all_different_users_per_game
    first_score = Game.find(self.game_id).scores[0]
    errors.add(:all_different_users_per_game, "can not use the same user twice") if !first_score.nil? and first_score.user_id == self.user_id
  end
  
  def update_membership
    game          = Game.find(self.game_id)
    leaderboard   = Leaderboard.find(game.leaderboard_id)
    membership    = Membership.first(:conditions => ['leaderboard_id=? and user_id=?', leaderboard.id, self.user_id])
    total_score   = 0
    sets_per_game = 0
    played_sets   = 0
    participated  = false
    leaderboard.games.each_with_index do |game, game_idx|
      game.scores.each_with_index do |score, score_idx|
        if game_idx > 0
          if score_idx == 0
            if participated
              played_sets += sets_per_game
              participated = false
            end
            sets_per_game = 0
          end
        end
        if (score.user_id == self.user_id)
          total_score += score.score
          participated = true
        end
        sets_per_game += score.score
      end
    end
    if participated
      played_sets += sets_per_game
    end
    membership.played_sets = played_sets
    membership.score       = total_score
    membership.update_attributes(membership)
  end
  
end
