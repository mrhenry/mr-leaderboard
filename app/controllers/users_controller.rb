class UsersController < ApplicationController
  
  before_filter :require_user, :only => [:show, :edit]
  before_filter :require_super_admin, :only => [:index]
  before_filter :require_no_user, :only => [:new, :create]
  
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
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      redirect_to user_url(@user.id), :notice => "User updated"
    else
      render :action => :edit
    end
  end
  
  def edit_password
    @user = User.find(params[:user_id])
  end
  
  def update_password
    @user = User.find(params[:user_id])
    
    if @user.update_attributes(params[:user])
      redirect_to user_url(@user.id), :notice => "Password changed"
    else
      render :action => :edit_password
    end
  end
  
end
