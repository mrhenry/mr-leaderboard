module ApplicationHelper
  
  def gravatar(email, size)
    sha = Digest::MD5.hexdigest(email).to_s
    return "http://www.gravatar.com/avatar/#{sha}?s=#{size}"
  end
  
end
