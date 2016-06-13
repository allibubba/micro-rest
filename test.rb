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
   post '/inventory', :size_1 => 34, :size_2 => 25, :size_3 => 89
   assert_equal last_response.status, 200
 end

 ## Read
 def test_inventory_read
   get '/inventory', :id => 1
   assert_equal last_response.status, 200
   assert_equal last_response.header['Cntent-type'], 'application/json'
 end

 ## Update
 def test_inventory_update
   put '/inventory', :size_1 => 10, :size_2 => 10, :size_3 => 10
   assert_equal last_response.status, 200
   assert_equal last_response.header['Cntent-type'], 'application/json'
 end

 ## Delete
 def test_inventory_delete
   delete '/inventory', :id => 1
   assert_equal last_response.status, 200
   assert_equal last_response.header['Cntent-type'], 'application/json'
 end










end
