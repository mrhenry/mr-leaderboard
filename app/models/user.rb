class User < ActiveRecord::Base
  
  acts_as_authentic
  
  has_many :memberships
  has_many :leaderboards, :through => :memberships
  has_many :games
  
  validates_length_of :display_name, :maximum => 3
  validates_presence_of :display_name
  
  before_save :set_user_level
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
  
  def deliver_welcome!
    reset_perishable_token!
    Notifier.deliver_welcome(self)
  end
  
  def activate!
    self.active = true
    save
  end
  
private

  def set_user_level
    self.level = 0 if self.level.nil?
  end

end
