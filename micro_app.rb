require 'sinatra'
require 'json'
require 'mongo'
require 'json/ext'
require File.join(Dir.pwd, "helpers", "mongo.rb")

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
      # find record
      id = object_id(id) if String === id
      if id.nil?
        {}.to_json
      else
        document = settings.mongo_db.find(:_id => id).to_a.first
        (document || {}).to_json
      end
    end

    put '/inventory/:id/?' do
      content_type :json
      # update record by id 
      id = object_id(params[:id])
      settings.mongo_db.find(:_id => id).
      find_one_and_update('$set' => request.params)
      document_by_id(id)
    end

    delete '/inventory/:id' do
      content_type :json
      # delete record where id
      db = settings.mongo_db
      id = object_id params[:id]
      if !documents.to_a.first.nil?
        documents.find_one_and_delete
        {:success => true}.to_json
      else
        {:success => false}.to_json
      end
    end



  end
end
