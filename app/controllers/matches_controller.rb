class MatchesController < ApplicationController
  
  def show
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.find(params[:id])
  end
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.new
  end
  
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.new(params[:match])
    
    if @match.save
      render :show
    else
      render :new
    end
  end
  
  def edit
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.find(params[:id])
  end
  
  def destroy
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to leaderboard_url(@leaderboard), :notice => "Match deleted"
  end
  
end
