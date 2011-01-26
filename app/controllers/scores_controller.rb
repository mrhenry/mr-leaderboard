class ScoresController < ApplicationController
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game        = Game.find(params[:game_id])
    @score       = Score.new
  end
  
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @game        = Game.find(params[:game_id])
    @score       = Score.new(params[:score])
    
    if @score.save
      if @game.scores.count == 2
        send_game_confirmation
        notice = "Score added."
      else
        notice = "Score added."
      end
      redirect_to leaderboard_game_url(params[:leaderboard_id], params[:game_id]), :notice => notice
    else
      redirect_to leaderboard_game_url(params[:leaderboard_id], params[:game_id]), :notice => "Score not added because validation failure"
    end
  end

private

  def send_game_confirmation
    @game.scores.each do |score|
      score_user = User.find(score.user_id)
      unless score_user == current_user
        #UserMailer.game_confirmation(score_user, @game).deliver
      end
    end
  end
  
end
