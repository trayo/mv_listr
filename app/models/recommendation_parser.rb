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
    returned_hash
  end
end

