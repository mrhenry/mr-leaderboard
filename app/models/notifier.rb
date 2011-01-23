class Notifier < ActionMailer::Base
  
  def activation_instructions(user)
    subject     "Activation instructions"
    from        "yves@mrhenry.be"
    recipients  user.email
    sent_on     Time.now
    body        :account_activation_url => activate_url(user.perishable_token)
  end
  
  def welcome(user)
    subject     "Welcome to Mr. Leaderboard"
    from        "yves@mrhenry.be"
    recipients  user.email
    sent_on     Time.now
    body        :root_url => root_url
  end
  
end
