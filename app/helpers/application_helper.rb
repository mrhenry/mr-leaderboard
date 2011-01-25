module ApplicationHelper
  
  def is_super_admin?
    if current_user and current_user.level.to_i >= 2
      return true
    else
      return false
    end
  end
  
  def gravatar(email, size = 100)
    sha = Digest::MD5::hexdigest(email)
    return "http://www.gravatar.com/avatar/#{sha}?s=#{size}"
  end
  
end
