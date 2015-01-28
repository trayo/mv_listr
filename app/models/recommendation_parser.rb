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


  def self.clean_up(data)
    RECOMMENDATION_ATTRIBUTES.each do |old_key, new_key|
      data[new_key] = data.delete old_key
    end
    data["title"].downcase!
    swap_imdb_poster_with_omdb(data)
    data
  end

  private

  def self.swap_imdb_poster_with_omdb(data)
    imdb_id = data["imdb_ID"]
    data["poster"] = "http://img.omdbapi.com/?i=#{imdb_id}&apikey=c2505740"
  end
end

