class AddWatchedToUserRecommendation < ActiveRecord::Migration
  def change
    add_column :user_recommendations, :watched, :boolean, :default => false
  end
end
