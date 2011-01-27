class User < ActiveRecord::Base
  
  acts_as_authentic
  
  has_many :memberships
  has_many :leaderboards, :through => :memberships
  has_many :matches
  
  validates_length_of :display_name, :maximum => 3
  validates_presence_of :display_name
  
  before_save :set_user_level
  
  def activate!
    self.active = true
    save
  end
  
  def is_leaderboard_user?
    raise @leaderboard.inspect
  end
  
  def is_admin?
    self.level.to_i >= 2
  end
  
private

  def set_user_level
    self.level = 0 if self.level.nil?
  end

end
