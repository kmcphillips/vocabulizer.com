Wordnik.configure do |config|
  config.api_key = Settings.wordnik_api_key
  config.response_format = "json"
end
