require 'qless'
require 'qless/server'

HTTP_PREFIX

client = Qless::Client.new(
  host: ENV['REDIS_HOST'],
  port: ENV['REDIS_PORT'].to_i,
  db: ENV['REDIS_DB'].to_i
)

QlessServer = Rack::Builder.app do
  map(ENV.fetch('HTTP_PATH', ENV['HTTP_PREFIX'])) { run Qless::Server.new(client) }
end

run QlessServer
