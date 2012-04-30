require 'sinatra/base'
require 'haml'
require 'coffee-script'
require 'sass'

module Tau
  class Server < Sinatra::Base
    def self.start
      set :port, 15000 # TODO: it should be changeable

      # TODO: / route should return list of all files
      get '/' do
        "There should be list of all files."
      end

      # html
      get /([\/\.\w-]+)\.html/ do |filename|
        filename = "code/#{filename}"
        return haml File.read("#{filename}.haml") if File.exist?("#{filename}.haml")
        send_file "#{filename}.html" if File.exist?("#{filename}.html")
        raise Sinatra::NotFound
      end

      # javascript
      get /js\/([\/\.\w-]+)\.js/ do |filename|
        filename = "code/js/#{filename}"
        return coffee File.read("#{filename}.coffee") if File.exist?("#{filename}.coffee")
        send_file "#{filename}.js" if File.exist?("#{filename}.js")
        raise Sinatra::NotFound
      end

      # css
      get /css\/([\/\.\w-]+)\.css/ do |filename|
        filename = "code/css/#{filename}"
        return sass File.read("#{filename}.sass") if File.exist?("#{filename}.sass")
        return scss File.read("#{filename}.scss") if File.exist?("#{filename}.scss")
        send_file "#{filename}.css" if File.exist?("#{filename}.css")
        raise Sinatra::NotFound
      end

      # images
      get /img\/([\/\.\w-]+)/ do |filename|
        filename = "code/img/#{filename}"
        send_file filename if File.exist?(filename)
        raise Sinatra::NotFound
      end

      not_found do
        "No such file or directory"
      end

      run!
    end
  end
end
