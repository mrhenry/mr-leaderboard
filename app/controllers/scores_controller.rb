class ScoresController < ApplicationController
  
  def new
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match       = Match.find(params[:match_id])
    @score       = Score.new
  end
  
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    @match       = Match.find(params[:match_id])
    @score       = Score.new(params[:score])
    
    if @score.save
      if @match.scores.count == 2
        notice = "Score added."
        redirect_to leaderboard_url(params[:leaderboard_id]), :notice => "Score added"
      else
        notice = "Score added."
        redirect_to leaderboard_match_url(params[:leaderboard_id], params[:match_id]), :notice => "Score added"
      end
    else
      redirect_to leaderboard_match_url(params[:leaderboard_id], params[:match_id]), :notice => "Score not added because validation failure"
    end
  end

private

end
