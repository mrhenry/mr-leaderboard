class MatchesController < ApplicationController
  
  before_filter :require_user, :only => [:index, :show, :new, :create, :edit, :destroy]
  
  def index
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
  end
  
  def show
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.find(params[:id])
  end
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match = Match.new(
      :leaderboard_id => @leaderboard.id
    )
    create
  end
  
  def create
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
