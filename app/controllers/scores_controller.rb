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
        #send_match_confirmation
        notice = "Score added."
      else
        notice = "Score added."
      end
      redirect_to leaderboard_match_url(params[:leaderboard_id], params[:match_id]), :notice => notice
    else
      redirect_to leaderboard_match_url(params[:leaderboard_id], params[:match_id]), :notice => "Score not added because validation failure"
    end
  end

private

  def send_match_confirmation
    @match.scores.each do |score|
      score_user = User.find(score.user_id)
      unless score_user == current_user
        #UserMailer.match_confirmation(score_user, @match).deliver
      end
    end
  end
  
end
