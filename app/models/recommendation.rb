class Recommendation < ActiveRecord::Base
  has_many :user_recommendations
  has_many :users, through: :user_recommendations

  validates :title, :year, :rated, :released,
            :runtime, :genre, :director, :writer,
            :actors, :plot, :language, :country,
            :awards, :poster, :metascore, :imdb_rating,
            :imdb_ID, :media_type, presence: true

  def self.service
    @service ||= OmdbService.new
  end

  def self.find_or_create_media(title, media_type = "movie", year = "")
    if Recommendation.exists?(title: title)
      Recommendation.find_by(title: title)
    else
      _build_recommendation(service.media(title, media_type, year))
    end
  end

  def self._build_recommendation(data)
    self.create!(RecommendationParser.clean_up(data))
  end
end
