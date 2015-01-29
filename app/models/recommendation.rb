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
    if not_matching_movie_in_database?(title)
      make_a_request_and_build_recommendation(title, media_type, year)
    else
      Recommendation.find_by("title LIKE ?", "%#{title.downcase}%")
    end
  end

  def self._build_recommendation(request_from_omdb)
    self.create!(RecommendationParser.new(request_from_omdb).clean_up)
  end

  private

  def self.movie_found?
    @request_from_omdb["Response"] != "False"
  end

  def self.not_adult_content?
    !@request_from_omdb["Genre"].include?("Adult")
  end

  def self.not_matching_movie_in_database?(title)
    Recommendation.where("title LIKE ?", "%#{title.downcase}%").empty?
  end

  def self.make_a_request_and_build_recommendation(title, media_type, year)
    @request_from_omdb = service.media(title, media_type, year)

    if movie_found? && not_adult_content?
      _build_recommendation(@request_from_omdb)
    else
      return @request_from_omdb["Error"] || "Adult movie found."
    end
  end
end
