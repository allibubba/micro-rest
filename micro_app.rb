require 'sinatra'
require 'json'
require 'mongo'
require 'json/ext'

module Micro
  class MyApp < Sinatra::Base

    ## config DB
    configure do
      db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'test')  
      set :mongo_db, db[:test]
     end

    ## Endpoints
    
    post '/inventory/?' do
      content_type :json
      # create record
       db = settings.mongo_db
       result = db.insert_one params
       db.find(:_id => result.inserted_id).to_a.first.to_json
    end

    get '/inventory/:id/?' do
      content_type :json
      # query inventory by id
    end

    put '/inventory/:id/?' do
      content_type :json
      # update record by id 
    end

    delete '/remove/:id' do
      content_type :json
      # delete record where id
    end










  end
end
