class AddWonMatchesToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :won_matches, :integer, :default => 0
  end

  def self.down
    remove_column :memberships, :won_matches
  end
end
