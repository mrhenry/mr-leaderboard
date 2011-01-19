class CreateLeaderboardsUsers < ActiveRecord::Migration
  def self.up
    create_table :leaderboards_users, :id => false do |t|
      t.integer :leaderboard_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :leaderboards_users
  end
end
