class CreateJoinTableUserRecommendation < ActiveRecord::Migration
  def change
    create_table :user_recommendations do |t|
      t.integer :user_id
      t.integer :recommendation_id
      t.integer :count, :default => 0

      t.timestamps null: false
    end
  end
end
