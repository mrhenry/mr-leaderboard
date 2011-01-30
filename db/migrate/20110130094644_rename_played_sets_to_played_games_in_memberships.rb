class RenamePlayedSetsToPlayedGamesInMemberships < ActiveRecord::Migration
  def self.up
    rename_column :memberships, :played_sets, :played_games
  end

  def self.down
    rename_column :memberships, :played_games, :played_sets
  end
end
