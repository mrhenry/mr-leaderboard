class LeaderboardsController < ApplicationController
  
  before_filter :require_super_admin, :only => [:edit, :update, :destroy]
  
  def index
    @leaderboards = Leaderboard.all
  end
  
  def show
    @leaderboard = Leaderboard.find(params[:id])
  end
  
  def new
    @leaderboard = Leaderboard.new
  end
  
  def create
    @leaderboard = Leaderboard.new(params[:leaderboard])
    
    if @leaderboard.save
      redirect_to leaderboards_url
    else
      render :action => :new
    end
  end
  
  def edit
    @leaderboard = Leaderboard.find(params[:id])
    @leaderboard_user_ids = @leaderboard.users.collect { |user| user.id.to_i }
  end
  
  def update
    @leaderboard = Leaderboard.find(params[:id])
    params[:leaderboard][:user_ids] ||= []
    
    if @leaderboard.update_attributes(params[:leaderboard])
      flash[:notice] = "Leaderboard successfully updated"
      render :show
    else
      render :edit
    end
  end
  
  def destroy
    @leaderboard = Leaderboard.find(params[:id])
    @leaderboard.destroy
    redirect_to leaderboards_url
  end
  
end
