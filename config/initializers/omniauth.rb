Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["TWITTER_CONSUMER_TOKEN"], ENV["TWITTER_CONSUMER_SECRET"]
end
