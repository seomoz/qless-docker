require 'qless'
require 'qless/server'

# use REDIS_URL="redis://some-host:7000/3"

if ENV['REDIS_URL']
  client = Qless::Client.new
else
  client = Qless::Client.new(:host => ENV['REDIS_HOST'], :port => ENV['REDIS_PORT'].to_i, :db => ENV['DB_NUM'].to_i )
end

if ENV['QLESS_SET_HEARTBEAT'].to_i > 0
  client.config['heartbeat'] = ENV['QLESS_SET_HEARTBEAT'].to_i
end
if ENV['QLESS_SET_MAX_WORKER_AGE'].to_i > 0
  client.config['max-worker-age'] = ENV['QLESS_SET_MAX_WORKER_AGE'].to_i
end

QlessServer = Rack::Builder.app do
  if ENV['QLESS_BASIC_AUTH_USER'] && ENV['QLESS_BASIC_AUTH_PASSWORD']
    use Rack::Auth::Basic, "qless" do |username, password|
      username == ENV['QLESS_BASIC_AUTH_USER'] && password == ENV['QLESS_BASIC_AUTH_PASSWORD']
    end
  end

  gui_path = ENV.fetch('HTTP_PATH', '/qless')

  map(gui_path) { run Qless::Server.new(client) }
end

run QlessServer
