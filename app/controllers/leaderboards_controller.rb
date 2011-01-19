class LeaderboardsController < ApplicationController
  
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
