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
   # TODO: check record count to ensure new record is created
 end

 ## Read
 def test_inventory_read
   get '/inventory', :id => 1
   assert_equal last_response.status, 200
   assert_equal last_response.header['Cntent-type'], 'application/json'
   #TODO: create new record, assert content.body contains record data
 end

 ## Update
 def test_inventory_update
   put '/inventory', :id => 1, :size_1 => 10, :size_2 => 10, :size_3 => 10
   assert_equal last_response.status, 200
   assert_equal last_response.header['Cntent-type'], 'application/json'
   #TODO: need to assert updated data in response body
 end

 ## Delete
 def test_inventory_delete
   delete '/inventory', :id => 1
   assert_equal last_response.status, 200
   assert_equal last_response.header['Cntent-type'], 'application/json'
   #TODO: create new record, need to ensure record is destroyed
 end










end
