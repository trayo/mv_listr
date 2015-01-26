class RecommendationParser

  RECOMMENDATION_ATTRIBUTES = %w(title year rated released runtime genre
                                 director writer actors plot language
                                 country awards poster metascore imdb_rating
                                 imdb_votes imdb_ID media_type response)

  def self.clean_up(data)
    returned_hash = {}
    data.each_with_index do |pairs, i|
      returned_hash["#{RECOMMENDATION_ATTRIBUTES[i]}"] = pairs.second
    end
    swap_imdb_poster_with_omdb(returned_hash)
    returned_hash
  end

  def self.swap_imdb_poster_with_omdb(returned_hash)
    imdb_id = returned_hash["imdb_ID"]
    returned_hash["poster"] = "http://img.omdbapi.com/?i=#{imdb_id}&apikey=#{ENV["OMDB_POSTER_KEY"]}"
  end
end

