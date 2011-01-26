class AddScoreToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :score, :integer, :default => 0
  end

  def self.down
    remove_column :memberships, :score, :default => 0
  end
end
