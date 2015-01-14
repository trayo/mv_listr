class Recommendation < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :title, :year, :rated, :released,
            :runtime, :genre, :director, :writer,
            :actors, :plot, :language, :country,
            :awards, :poster, :metascore, :imdb_rating,
            :imdb_ID, :type, presence: true
end
