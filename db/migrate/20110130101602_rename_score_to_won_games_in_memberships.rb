class RenameScoreToWonGamesInMemberships < ActiveRecord::Migration
  def self.up
    rename_column :memberships, :score, :won_games
  end

  def self.down
    rename_column :memberships, :won_games, :score
  end
end
