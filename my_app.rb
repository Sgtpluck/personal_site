#my_app.rb
require 'sinatra'
require 'yaml'


class MyApp < Sinatra::Base

    before do
      @posts = Dir.glob("views/posts/*.erb").map do |post_name|
        post_name.split("/").last.split(".").first
      end
      @sorted_posts = meta_data.sort_by {|post, data_hash| data_hash["date"] }.reverse
    end

    get '/' do
      erb :index, :locals=> {:title => "Davida Marion."}
    end

    get '/posts/' do
      erb :posts, :layout => :pages, :locals=> {:title => "This. Is. Serious."}
    end

    get '/posts/:post_name' do
      page = erb("/posts/#{params[:post_name]}".to_sym, layout: false).split("\n\n",2).last
      erb page, :layout => :pages, :locals=> {:anchor=> "<a href='./'>Go Back</a>"}
    end

    def meta_data
      if @meta_data
        @meta_data
      else
        @meta_data = {}
        @posts.each do |post|
          html = erb("/posts/#{post}".to_sym, layout: false)
          data = YAML.load(html.split("\n\n",2).first)
          @meta_data[post] = data
        end
      end      
      @meta_data
    end

end