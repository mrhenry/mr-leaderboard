class Score < ActiveRecord::Base
  
  has_one :user
  has_one :game
  
  before_save :only_2_scores_per_game
  
private

  def only_2_scores_per_game
    Rails.logger.debug('--------------')
    Rails.logger.debug('--------------')
    Rails.logger.debug('--------------')
  end
  
end
