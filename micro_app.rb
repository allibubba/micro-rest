# require 'sinatra'
# require 'json'
# require 'mongo'
# require 'json/ext'
require 'mongoid'
require 'mongo'

# $:.unshift File.expand_path('../lib', __FILE__)  # add ./lib to $LOAD_PATH
require 'rubygems'
require 'sinatra'
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
    
    helpers do

      def object_id val
        begin
          BSON::ObjectId.from_string(val)
          BSON::ObjectId
        rescue BSON::ObjectId::Invalid
          nil
        end
      end

      def document_by_id id
        id = object_id(id) if String === id
        if id.nil?
          {}.to_json
        else
          document = settings.mongo_db.find(:_id => id).to_a.first
          (document || {}).to_json
        end
      end
    end


    configure do
      db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'micro')  
      set :mongo_db, db[:micro]
      Mongoid.configure do |config|
        config.sessions = {
          :default => {
            :hosts => ["localhost:27017"], :database => "micro"
          }
        }
      end
    end


    get '/' do
      Inventory.all.to_json
    end

    get '/collections/?' do
      content_type :json
      settings.mongo_db.database.collection_names.to_json
    end

    ## Endpoints

    # create record
    post '/inventory' do
      content_type :json
      i = Inventory.new params
      if i.save
        puts i.to_json
      end

      # db = settings.mongo_db
      # result = db.insert_one params
      # db.find(:_id => result.inserted_id).to_a.first.to_json
    end

    # find record
    get '/inventory/:id/?' do
      content_type :json
      i = Inventory.where('_id' => params[:id]).first
      puts '---------------------------------------------------------------------------'
      puts i.to_json
      puts '---------------------------------------------------------------------------'
      i

      # document_by_id(params[:id])
    end

    # update record by id 
    put '/inventory/:id/?' do
      content_type :json
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
