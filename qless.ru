require 'qless'
require 'qless/server'

# use REDIS_URL="redis://some-host:7000/3"
client = Qless::Client.new

QlessServer = Rack::Builder.app do
  if ENV['QLESS_BASIC_AUTH_USER'] && ENV['QLESS_BASIC_AUTH_PASSWORD']
    use Rack::Auth::Basic, "qless" do |username, password|
      username == ENV['QLESS_BASIC_AUTH_USER'] && password == ENV['QLESS_BASIC_AUTH_PASSWORD']
    end
  end

  gui_path = '/qless'
  if ENV['HTTP_PATH']
    gui_path = ENV['HTTP_PATH']
  end

  map(gui_path) { run Qless::Server.new(client) }
end

run QlessServer
