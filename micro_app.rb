require 'sinatra'
require 'json'

module Micro
  class MyApp < Sinatra::Base

    ## Endpoints
    
    post '/inventory/:id/?' do
      content_type :json
      # create record
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
