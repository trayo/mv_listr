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

  def self.find_or_create_media(title_or_id)
    if not_matching_movie_in_database?(title_or_id)
      make_a_request_and_build_recommendation(title_or_id)
    else
      find_by_title_or_imdb_id(title_or_id)
    end
  end

  def self.build_recommendation(request_from_omdb)
    create!(RecommendationParser.new(request_from_omdb).clean_up)
  end

  private

  def self.movie_found?
    @request_from_omdb["Response"] != "False"
  end

  def self.not_adult_content?
    !@request_from_omdb["Genre"].include?("Adult")
  end

  def self.not_matching_movie_in_database?(title_or_id)
    not_matching_by_title?(title_or_id) && not_matching_by_imdb_id?(title_or_id)
  end

  def self.find_by_title_or_imdb_id(title_or_id)
    if not_matching_by_title?(title_or_id)
      Recommendation.find_by(imdb_ID: title_or_id)
    else
      Recommendation.find_by("title LIKE ?", "%#{title_or_id.downcase}%")
    end
  end

  def self.not_matching_by_title?(title_or_id)
    Recommendation.where("title LIKE ?", "%#{title_or_id.downcase}%").empty?
  end

  def self.not_matching_by_imdb_id?(imdb_id)
    !Recommendation.exists?(imdb_ID: imdb_id)
  end

  def self.make_a_request_and_build_recommendation(title_or_id)
    @request_from_omdb = service.media(title_or_id)

    if movie_found? && not_adult_content?
      build_recommendation(@request_from_omdb)
    else
      return "Movie not found."
    end
  end
end
