class UserMailer < ActionMailer::Base
  default :from => "yves@mrhenry.be"
  
  def activation_instructions(user)
    @user = user
    @url  = activate_url(user.perishable_token)
    mail(:to => user.email,
         :subject => "Mr. Leaderboard activation instructions")
  end
  
  def welcome(user)
    @user = user
    @url  = root_url
    mail(:to => user.email,
         :subject => "Welcome to Mr. Leaderboard")
  end
  
  def game_confirmation(user, game)
    @game = game
    mail(:to => user.email,
         :subject => "Can you confirm this game?")
  end
  
end
