class CreateLeaderboards < ActiveRecord::Migration
  def self.up
    create_table :leaderboards do |t|
      t.string :title
      
      t.timestamps
    end
  end

  def self.down
    drop_table :leaderboards
  end
end
