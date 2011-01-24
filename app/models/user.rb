class User < ActiveRecord::Base
  
  acts_as_authentic
  
  has_many :memberships
  has_many :leaderboards, :through => :memberships
  has_many :games
  
  before_save :set_user_level
  
  def activate!
    self.active = true
    save
  end
  
private

  def set_user_level
    self.level = 0 if self.level.nil?
  end

end
