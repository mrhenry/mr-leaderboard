class LeaderboardsController < ApplicationController
  
  before_filter :require_super_admin, :only => [:edit, :update, :destroy]
  
  def index
    @leaderboards = Leaderboard.all
  end
  
  def show
    @leaderboard = Leaderboard.find(params[:id])
    
    @results = []
    
    @nr_months = @leaderboard.matches.all.map { |match| [match.created_at.strftime('%Y-%m')] }
    @nr_months.uniq!
    @nr_months.each do |month|
      
      # get all matches for month
      val = month[0]
      @matches_for_month = @leaderboard.matches.find_all{|match| match.created_at.strftime('%Y-%m') == val}
  
      # look up royalties for month
      @king = 0
      @royalties = []
      @matches_for_month.each do |match|
        
        # de 2 scores sorteren op score DESC -> hoogste vanboven
        if match.scores.size > 1
          
          @match_result = match.scores.all(:order => 'score DESC')
          # de winnaar is de eerste record
          @prince = @match_result[0] 
          # save membership
          @royalties.push @prince.membership_id
        
        end
      
      end
      
      # determine the king for the month
      # do a hash count (php style array_count_values)
      counting = {}
      @royalties.each do |royal|
          counting[royal] ||= 0
          counting[royal] += 1
      end
      
      # check for king
      temp_val = 0
      @royalties.each do |royal|
          
          if counting[royal] > temp_val
            @king = royal
          end
          
          temp_val = counting[royal]
   
      end
      
      # find user
      @neo = User.find(Membership.find(@king).user_id)
     
      # write result
      @result = {:month => month, :nr_matches => @matches_for_month.length, :king => @neo.display_name, :king_matches => counting[@king]}
  
      # log
      # Rails.logger.debug('---------------')
      # Rails.logger.debug(val)
      # Rails.logger.debug(@matches_for_month.length)
      # Rails.logger.debug('---------------')
      
      # push to results
      @results.push @result
      
    end
    
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
    
    # Reset memberships
    @leaderboard.memberships.each do |membership|
      membership.reset
    end
    
    # Update memberships
    @leaderboard.matches.each do |match|
      match.add_membership_statistics
    end
    
    flash[:notice] = "Leaderboard recalculation complete"
    redirect_to leaderboard_url(@leaderboard)
    
  end
  
end
