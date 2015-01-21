class AddImdbVotesAndResponseToRecommendation < ActiveRecord::Migration
  def change
    add_column :recommendations, :imdb_votes, :string
    add_column :recommendations, :response, :string
  end
end
