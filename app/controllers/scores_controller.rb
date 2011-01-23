class ScoresController < ApplicationController
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.find(params[:game_id])
    @score = Score.new
  end
  
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game = Game.find(params[:game_id])
    @score = Score.new(params[:score])
    
    if @score.save
      flash[:notice] = "Score added"
      redirect_to leaderboard_game_url(params[:leaderboard_id], params[:game_id])
    else
      flash[:notice] = "Score not added because validation failure"
      redirect_to leaderboard_game_url(params[:leaderboard_id], params[:game_id])
    end
  end
  
end
