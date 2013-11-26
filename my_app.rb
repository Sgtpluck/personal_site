#my_app.rb
require 'sinatra'

class MyApp < Sinatra::Base
 
  get '/' do
    erb :index
  end

  get '/info' do
    erb :info
  end

  get '/work' do
    erb :work
  end

  get '/news' do
    erb :news
  end

  get '/contact' do
    erb :contact
  end

  get '/cute_pictures_of_animals' do
    erb :cute_pictures_of_animals
  end

end