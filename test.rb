ENV['RACK_ENV'] = 'test'

require File.join(Dir.pwd, "micro_app.rb")
require 'test/unit'
require 'rack/test'


class App < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Micro::MyApp
  end

# Product ID
# Size_1 = <quantity>
# Size_2 = <quantity>
# Size_3 = <quantity>


### CRUD
 ## Create

 def test_inventory_create
   post '/inventory'

 end

 ## Read
 def test_inventory_create
   get '/inventory'

 end

 ## Update
 def test_inventory_create
   put '/inventory'

 end

 ## Delete
 def test_inventory_create
   delete '/inventory'

 end














end
