class LeaderboardsController < ApplicationController
  
  before_filter :require_super_admin, :only => [:edit, :update, :destroy]
  
  def index
    @leaderboards = Leaderboard.all
  end
  
  def show
    @leaderboard = Leaderboard.find(params[:id])
    render :show
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
  
  def recalculate_memberships
    @leaderboard = Leaderboard.find(params[:id])
    
    @leaderboard.memberships.each do |membership|
      membership.reset
    end
    
    @leaderboard.matches.each do |match|
      
      # Set played games
      total_match_games = 0
      if match.scores.count > 1
        total_match_games = 0
        match.scores.each do |score|
          total_match_games += score.score
        end
        match.scores.each do |score|
          membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, score.user_id])
          membership.played_games += total_match_games
          membership.update_attributes(membership)
        end
      end
      
      # set won games & played matches
      match.scores.each do |score|
        score.update_membership_won_games
        score.update_membership_played_matches
      end
      
      # set won matches
      if match.scores.count > 1
        highest_score = nil
        match.scores.each do |score|
          match.scores.each do |score|
            highest_score = score if highest_score.nil? or score.score > highest_score.score
          end
        end
        membership = Membership.first(:conditions => ["leaderboard_id = ? and user_id = ?", match.leaderboard_id, highest_score.user_id])
        membership.won_matches += 1
        membership.update_attributes(membership)
      end
      
    end
    
    flash[:notice] = "Leaderboard recalculation complete"
    redirect_to leaderboard_url(@leaderboard)
    
  end
  
end
