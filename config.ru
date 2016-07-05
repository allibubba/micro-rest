# config.ru (run with rackup)
require './micro_app'
set :environment, :development
set :sessions, true
set :server, :puma
run Micro::MyApp
