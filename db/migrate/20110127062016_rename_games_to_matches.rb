class RenameGamesToMatches < ActiveRecord::Migration
  def self.up
    rename_table :games, :matches
    rename_column :scores, :game_id, :match_id
  end

  def self.down
    rename_table :matches, :games
    rename_column :scores, :match_id, :game_id
  end
end
