Rails.application.config.middleware.use OmniAuth::Builder do
  provider :runkeeper, ENV['RUNKEEPER_CLIENT_ID'], ENV['RUNKEEPER_CLIENT_SECRET']
  provider :moves, ENV['MOVES_KEY'], ENV['MOVES_SECRET']
end