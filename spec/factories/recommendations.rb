FactoryGirl.define do
  factory :recommendation do
    title       "Looper"
    year        "2012"
    rated       "R"
    released    "28 Sep 2012"
    runtime     "119 min"
    genre       "Action, Crime, Sci-Fi"
    director    "Rian Johnson"
    writer      "Rian Johnson"
    actors      "Joseph Gordon-Levitt, Bruce Willis, Emily Blunt, Paul Dano"
    plot        "In 2074, when the mob wants to get rid of someone, the " +
                "target is sent into the past, where a hired gun awaits " +
                "- someone like Joe - who one day learns the mob wants " +
                "to 'close the loop' by sending back Joe's future self " +
                "for assassination."
    language    "English"
    country     "USA, China"
    awards      "15 wins & 35 nominations."
    poster      "http://ia.media-imdb.com/images/M/MV5BMTY3NTY0MjEwNV5BMl5BanBnXkFtZTcwNTE3NDA1OA@@._V1_SX300.jpg"
    metascore   "84"
    imdb_rating "7.5"
    imdb_ID     "tt1276104"
    media_type  "movie"
  end
end
