class GamesController < ApplicationController
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.new
  end
  
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.new(params[:game])
    
    if @game.save
      render :new
    else
      render :new
    end
  end
  
  def edit
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.find(params[:game_id])
  end
  
end
