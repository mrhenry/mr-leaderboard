ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "leaderboards.mrhenry.be",  
  :user_name            => "mrleaderboard",  
  :password             => "puzzlebobble",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}