class User < ActiveRecord::Base
  
  acts_as_authentic
  
  has_many :memberships
  has_many :leaderboards, :through => :memberships
  has_many :games
  
  before_save :set_user_level
  
private

  def set_user_level
    
  end
  
end
