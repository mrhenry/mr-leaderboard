class AddMembershipIdToScores < ActiveRecord::Migration
  def self.up
    add_column :scores, :membership_id, :integer
  end

  def self.down
    remove_column :scores, :membership_id, :integer
  end
end
