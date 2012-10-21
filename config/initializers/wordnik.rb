Wordnik.configure do |config|
  config.api_key = Configuration.wordnik_api_key
  config.response_format = "json"
end
