class OmdbService
  attr_reader :api

  def initialize
    @api ||= Faraday.new(url: "http://omdbapi.com/")
  end

  def media(title_or_ID)
    @title_or_ID = add_media_type(title_or_ID)

    parse(api.get("?#{@title_or_ID}&type=movie&plot=short&r=json"))
  end

  private

  def add_media_type(title_or_ID)
    title_or_ID.prepend(title_or_ID.include?("tt") ? "i=" : "t=")
  end

  def request_params
  end

  def parse(response)
    JSON.parse(response.body)
  end
end
