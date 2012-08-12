require 'sinatra/base'
require 'tau/enginer'
require 'tau/server/file_listing'

module Tau
  class Server < Sinatra::Base
    helpers Tau::ServerHelpers::FileListing

    def self.start
      set :server, SERVER
      set :port, Defaults::PORT # TODO: it should be changeable

      get FILE_PATH_EXP do |path|
        path = File.expand_path File.join(CODE_DIR, path) # we are currently in project dir

        show_list_of_files_on path if File.directory? path

        send_file path if File.exist? path

        # render file by one of engine if path isn't a directory or real file
        engine = Enginer.engine_for_render_to path
        if engine != nil
          engine.render_file engine.source_for(path)
        else
          raise Sinatra::NotFound
        end
      end

      not_found do
        show_list_of_files_on File.expand_path(CODE_DIR), "No such file or directory"
      end

      run!
    end
  end
end
