# require 'sinatra'
# require 'json'
# require 'mongo'
# require 'json/ext'

# $:.unshift File.expand_path('../lib', __FILE__)  # add ./lib to $LOAD_PATH
require 'rubygems'
require 'sinatra'
require 'mongoid'
require 'bson'
require 'json/ext' # required for .to_json

module Micro

  class Inventory
    include Mongoid::Document
    field :title, :type => String
    field :count, :type => Integer
    field :product_id, :type => Integer
  end


  class MyApp < Sinatra::Base
    use Rack::MethodOverride

    configure do
      Mongoid.configure do |config|
        config.sessions = {
          :default => {
            :hosts => ["localhost:27017"], :database => "test"
          }
        }
      end
    end

    ## Endpoints
    get '/' do
      Inventory.all.to_json
    end
    # create record
    post '/inventory' do
      content_type :json
      inventroy = Inventory.new params
      if inventroy.save
        inventory.to_json
      end
    end

    # find record
    get '/inventory/:product_id' do
      content_type :json
      inventory = Inventory.where(:product_id => params[:product_id])
      inventory.to_json

    end

    # update record by id 
    put '/inventory/:product_id?' do
      content_type :json
      inventory = Inventory.where(:product_id => params[:product_id])
      inventory.update_attributes(params[:inventory])
      inventory.to_json
    end

    # delete
    delete '/inventory/:product_id' do
      content_type :json
      inventory = Inventory.where(:product_id => params[:product_id])
      if inventory.delete
        puts "deleted"
      else
        puts "not deleted"
      end
    end

  end
end
