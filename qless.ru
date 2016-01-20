require 'qless'
require 'qless/server'

client = Qless::Client.new(:host => ENV['REDIS_HOST'], :port => ENV['REDIS_PORT'].to_i, :db => ENV['DB_NUM'].to_i )

QlessServer = Rack::Builder.app do
  map(ENV['HTTP_PATH']) { run Qless::Server.new(client) }
end

run QlessServer
