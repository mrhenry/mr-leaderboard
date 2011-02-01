class AddPlayedMatchesToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :played_matches, :integer, :default => 0
  end

  def self.down
    remove_column :memberships, :played_matches
  end
end
