require 'thor'
require 'tau/projecter'
require 'tau/server'
require 'tau/version'

module Tau
  class Cli < Thor
    map '-v' => :version

    desc "new PROJECT_NAME", "Making new project"
    def new(project_name)
      begin
        Tau::Projecter.new_project(Dir.pwd, project_name)
      rescue Exception => e
        puts e.message
      end
    end

    desc :server, "Starting server for development"
    def server
      Tau::Server.start
    end

    desc :version, "Show tau version"
    def version
      puts "Tau #{Tau::VERSION}"
    end
  end
end
