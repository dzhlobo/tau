require 'sinatra/base'
require 'tau/enginer'

module Tau
  class Server < Sinatra::Base
    def self.start
      set :port, 15000 # TODO: it should be changeable

      # TODO: / route should return list of all files
      get '/' do
        "There should be list of all files."
      end

      get /^([[:word:]\.-\/]+)$/ do |filename|
        filename = "code/#{filename}" # TODO: think about security. User can send "../../" as filename.

        "There should be list of all files." if File.directory? filename

        send_file filename if File.exist? filename

        # render file by one of engine
        engine = Enginer.engine_for_render_to filename
        unless engine == nil
          engine.render_file engine.source_for(filename)
        else
          raise Sinatra::NotFound
        end
      end

      not_found do
        "No such file or directory"
      end

      run!
    end
  end
end
