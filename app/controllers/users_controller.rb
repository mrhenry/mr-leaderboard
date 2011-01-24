class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save_without_session_maintenance
      @user.reset_perishable_token!
      UserMailer.activation_instructions(@user).deliver
      redirect_to leaderboards_url, :notice => "Your user has been created. Please check your e-mail for activation instructions"
    else
      render :action => :new
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:user])
  end
  
end
