module ApplicationHelper
  
  def gravatar(email, size = 100)
    sha = Digest::MD5::hexdigest(email)
    return "http://www.gravatar.com/avatar/#{sha}?s=#{size}"
  end
  
end
