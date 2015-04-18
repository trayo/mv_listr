class OmdbService
  attr_reader :connection

  def initialize
    @connection ||= Faraday.new(url: "http://omdbapi.com/")
  end

  def media(title, media_type, year)
    type = title.include?("tt") ? "i" : "t"
    parse(connection.get("?#{type}=#{title}&type=#{media_type}&y=#{year}&plot=short&r=json"))
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end
end
