class Seeds
  NUMBER_OF_USERS           = 5
  NUMBER_OF_RECOMMENDATIONS = 10
  RATINGS                   = %w(G PG PG-13 R NC-17)
  MONTHS                    = %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
  GENRES                    = %w(Action Crime Sci-Fi Drama Mystery Thriller Horror)
  MEDIA_TYPES               = %w(movie series episode)

  def initialize
    generate_users_and_recommendations
  end

  def generate_users_and_recommendations
    NUMBER_OF_USERS.times do |i|
      user = User.create!(user_params)
      generate_recommendations(user)
    end
    puts "Users created!"
    puts "Recommendations created!"
  end

  private

  def generate_recommendations(user)
    NUMBER_OF_RECOMMENDATIONS.times do |i|
      recommendation = Recommendation.create!(recommendation_params)
      user.recommendations << recommendation
    end
  end

  def user_params
    { name:                     Faker::Name.first_name,
      screen_name:              Faker::Internet.user_name,
      provider:                "twitter",
      profile_image_url_https: "http://robohash.org/#{rand(10000)}.png?set=set1&size=200x200",
      uid:                     "#{random_twitter_uid}"
    }
  end

  def recommendation_params
    { title:       "#{Faker::App.name} #{Faker::App.name}",
      year:        "#{random_movie_year_starting_at_1920}",
      rated:       "#{RATINGS.sample}",
      released:    "#{random_release_date}",
      runtime:     "120 min",
      genre:       "#{GENRES.sample}",
      director:    Faker::Name.name,
      writer:      Faker::Name.name,
      actors:      "#{Faker::Name.name}, #{Faker::Name.name}, #{Faker::Name.name}",
      plot:        Faker::Lorem.sentence,
      language:    "English",
      country:     "USA",
      awards:      "Won #{rand(15)} Oscars. Another #{rand(50)} wins & #{rand(50)} nominations.",
      poster:      "http://robohash.org/#{rand(10000)}.png?set=set1&size=200x200",
      metascore:   "#{Random.rand(100)}",
      imdb_rating: "#{random_rating}",
      imdb_ID:     "tt#{random_imdb_id}",
      media_type:  "#{MEDIA_TYPES.sample}"
    }
  end

  def random_movie_year_starting_at_1920
    rand(1920..current_year_plus_one)
  end

  def random_twitter_uid
    rand(1000_0000..9999_9999)
  end

  def random_release_date
    "#{rand(1..31)} #{MONTHS.sample} #{random_movie_year_starting_at_1920}"
  end

  def current_year_plus_one
    Time.now.year + 1
  end

  def random_rating
    rand(7) + 4.0
  end

  def random_imdb_id
    rand(1_000_000..9_999_999)
  end
end

Seeds.new
