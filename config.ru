require 'fileutils'
require 'logger'
require 'sequel'
require 'pact_broker'
require 'pg'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV['PACT_BROKER_USERNAME'] and password == ENV['PACT_BROKER_PASSWORD']
end

app = PactBroker::App.new do | config |
  config.database_connection = Sequel.connect(ENV['DATABASE_URL'], adapter: "postgres", encoding: 'utf8')
end

run app
