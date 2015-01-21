class OmdbService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "http://www.omdbapi.com/?")
  end

  def movie(title, year = "")
    parse(connection.get("t=#{title}&y=#{year}&plot=short&r=json"))
  end

  def parse(response)
    JSON.parse(response.body)
  end
end
