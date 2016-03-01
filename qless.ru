require 'qless'
require 'qless/server'

client = Qless::Client.new(:host => ENV['REDIS_HOST'], :port => ENV['REDIS_PORT'].to_i, :db => ENV['DB_NUM'].to_i )

QlessServer = Rack::Builder.app do
  if ENV['QLESS_BASIC_AUTH_USER'] && ENV['QLESS_BASIC_AUTH_PASSWORD']
    use Rack::Auth::Basic, "qless" do |username, password|
      username == ENV['QLESS_BASIC_AUTH_USER'] && password == ENV['QLESS_BASIC_AUTH_PASSWORD']
    end
  end

  map(ENV['HTTP_PATH']) { run Qless::Server.new(client) }
end

run QlessServer
