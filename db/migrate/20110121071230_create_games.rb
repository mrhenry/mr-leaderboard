class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :leaderboard_id
      t.integer :user_id
      t.integer :score

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
