class OmdbService
  attr_reader :api

  def initialize
    @api ||= Faraday.new(url: "http://omdbapi.com/")
  end

  def media(title_or_id)
    @title_or_id = add_media_type(title_or_id)

    parse(api.get("?#{@title_or_id}&type=movie&plot=short&r=json"))
  end

  private

  def add_media_type(title_or_id)
    title_or_id.prepend(title_or_id.include?("tt") ? "i=" : "t=")
  end

  def request_params
  end

  def parse(response)
    JSON.parse(response.body)
  end
end
