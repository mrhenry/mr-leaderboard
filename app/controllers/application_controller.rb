class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :test
  helper_method :current_user_session, :current_user, :is_admin?, :is_super_admin?, :require_super_admin
  filter_parameter_logging :password, :password_confirmation
  
private

  def test
    #@leaderboard = Leaderboard.find(3)
    #@leaderboard.games.each do |game|
    #  game.scores.each do |score|
    #    Rails.logger.debug('-----------')
    #    Rails.logger.debug(score.inspect)
    #    Rails.logger.debug('-----------')
    #  end
    #end
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def require_super_admin
    if current_user and current_user.level.to_i >= 2
      return true
    else
      flash[:notice] = "You are not authorized to see this page"
      redirect_to root_url
      return false
    end
  end
  
end
