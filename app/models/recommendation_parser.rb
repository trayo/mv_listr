class RecommendationParser

  RECOMMENDATION_ATTRIBUTES = { "Title" => "title",         "Year"  => "year",
                                "Rated" => "rated",         "Released" => "released",
                                "Runtime" => "runtime",     "Genre" => "genre",
                                "Director" => "director",   "Writer" => "writer",
                                "Actors" => "actors",       "Plot" => "plot",
                                "Language" => "language",   "Country" => "country",
                                "Awards" => "awards",       "Poster" => "poster",
                                "Metascore" => "metascore", "imdbRating" => "imdb_rating",
                                "imdbVotes" => "imdb_votes", "imdbID" => "imdb_ID",
                                "Type" => "media_type",     "Response" => "response"
                              }

  def initialize(recommendation_json_from_omdb)
    @recommendation_json_from_omdb = recommendation_json_from_omdb
  end

  def clean_up
    RECOMMENDATION_ATTRIBUTES.each do |old_key, new_key|
      recommendation_json_from_omdb[new_key] = recommendation_json_from_omdb.delete old_key
    end
    recommendation_json_from_omdb["title"].downcase!
    swap_imdb_poster_with_omdb
    recommendation_json_from_omdb
  end

  private

  attr_reader :recommendation_json_from_omdb

  def swap_imdb_poster_with_omdb
    imdb_id = recommendation_json_from_omdb["imdb_ID"]
    recommendation_json_from_omdb["poster"] = "http://img.omdbapi.com/?i=#{imdb_id}&apikey=c2505740"
  end
end

