#my_app.rb
require 'sinatra'
require 'yaml'


class MyApp < Sinatra::Base

    before do
      @posts = Dir.glob("views/posts/*.erb").map do |post_name|
        post_name.split("/").last.split(".").first
      end
    end

    get '/' do
      erb :index
    end

    get '/posts/' do
      erb :posts
    end

    get '/posts/:post_name' do
      page = erb("/posts/#{params[:post_name]}".to_sym, layout: false).split("\n\n",2).last
      erb page
    end

    def meta_data
      if @meta_data
        @meta_data
      else
        @meta_data = {}
        @posts.each do |post|
          html = erb("/posts/#{post}".to_sym, layout: false)
          meta = YAML.load(html.split("\n\n",2).first)
          @meta_data[post] = meta
        end
      end
      @meta_data
    end

end