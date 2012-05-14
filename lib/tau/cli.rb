require 'thor'
require 'tau/server'
require 'tau/projecter'

module Tau
  class Cli < Thor

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
  end
end