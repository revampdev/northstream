MuxRuby.configure do |config|
  config.username = Rails.application.credentials.config[:mux][:token_id]
  config.password = Rails.application.credentials.config[:mux][:secret_key]
end
