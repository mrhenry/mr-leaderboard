class AddPlayedSetsToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :played_sets, :integer, :default => 0
  end

  def self.down
    remove_column :memberships, :played_sets
  end
end
