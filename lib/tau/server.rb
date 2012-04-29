require 'sinatra/base'
require 'haml'
require 'coffee-script'
require 'sass'

module Tau
  class Server < Sinatra::Base
    def self.start
      set :port, 15000

      get '/' do
        "hello"
      end

      # html
      get '/:filename.html' do
        return haml File.read("code/#{params[:filename]}.haml") if File.exist?("code/#{params[:filename]}.haml")
        send_file "code/#{params[:filename]}.html" if File.exist?("code/#{params[:filename]}.html")
      end

      # javascript
      get '/js/:filename.js' do
        return coffee File.read("code/js/#{params[:filename]}.coffee") if File.exist?("code/js/#{params[:filename]}.coffee")
        send_file "code/js/#{params[:filename]}.js" if File.exist?("code/js/#{params[:filename]}.js")
      end

      # css
      get '/css/:filename.css' do
        return sass File.read("code/css/#{params[:filename]}.sass") if File.exist?("code/css/#{params[:filename]}.sass")
        return scss File.read("code/css/#{params[:filename]}.scss") if File.exist?("code/css/#{params[:filename]}.scss")
        send_file "code/css/#{params[:filename]}.css" if File.exist?("code/css/#{params[:filename]}.css")
      end

      # images
      get %r{/img/(.+)} do
        send_file "code/img/#{params[:captures].first}"
      end

      get %r{/(.+)} do
        "unknown request: <b>#{params[:captures].first}</b>"
      end

      run!
    end
  end
end
