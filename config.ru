# config.ru (run with rackup)
require './micro_app'
set :environment, :development
set :sessions, true
run Micro::MyApp
