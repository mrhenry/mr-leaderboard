class ActivationsController < ApplicationController
  
  before_filter :require_no_user
  
  def create
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    #raise Exception if @user.active?
    
    if @user.activate!
      @user.reset_perishable_token!
      UserMailer.welcome(@user).deliver
      UserSession.create(@user)
      redirect_to leaderboards_url, :notice => "Your user has been activated!"
    else
      render :action => :new
    end
  end

end
