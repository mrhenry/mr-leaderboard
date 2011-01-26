class UsersController < ApplicationController
  
  before_filter :require_user, :only => [:show, :edit]
  before_filter :require_super_admin, :only => [:index]
  before_filter :requre_no_user, :only => [:new, :create]
  
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
      @user.deliver_activation_instructions!
      flash[:notice] = "Your user has been created. Please check your e-mail for activation instructions"
      redirect_to leaderboards_url
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
  
end
