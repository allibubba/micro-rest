
require File.join(Dir.pwd, "micro_app.rb")
require 'test/unit'
require 'rack/test'
require "mocha/test_unit"
ENV['RACK_ENV'] = 'test'


class App < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Micro::MyApp
  end

  ### Models
  def test_mocking_inventory
    inventory = Micro::Inventory.new
    Micro::Inventory.expects(:find).with(1).returns(inventory)
    assert_equal inventory, Micro::Inventory.find(1)
  end


  ### CRUD

  ## Create
  def test_inventory_create
    post '/inventory', :title => 'test title', :count => 25, :product_id => 89
    assert_equal last_response.status, 200
  end

  ## Read
  def test_inventory_read
    data = {product_id:1}
    i = Micro::Inventory.create data
    get "/inventory/#{i.product_id}"
    assert_equal last_response.status, 200
    assert_equal last_response.header['Content-type'], 'application/json'
  end

  ## Update
  def test_inventory_update
    Micro::Inventory.create({ product_id:101, title:"old title"})
    put '/inventory/101', :title => 'superTitleName'
    assert_equal last_response.status, 200
    assert_equal last_response.header['Content-type'], 'application/json'
    assert last_response.body.include?('superTitleName')
  end

  ## Delete
  def test_inventory_delete
    data = {product_id:1}
    i = Micro::Inventory.create data
    delete "/inventory/#{i.product_id}"
    assert_equal last_response.status, 200
    assert_equal last_response.header['Content-type'], 'application/json'
  end

end
