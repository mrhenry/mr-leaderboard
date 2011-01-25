class GamesController < ApplicationController
  
  def show
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.find(params[:id])
  end
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.new
  end
  
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.new(params[:game])
    
    if @game.save
      render :show
    else
      render :new
    end
  end
  
  def edit
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.find(params[:id])
  end
  
  def destroy
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to leaderboard_url(@leaderboard), :notice => "Game deleted"
  end
  
end
