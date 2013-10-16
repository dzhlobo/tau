# Include useful steps.
# See full list at https://github.com/cucumber/aruba/blob/master/lib/aruba/cucumber.rb
require 'aruba/cucumber'

# Include aruba api for own steps
# See https://github.com/cucumber/aruba/blob/master/lib/aruba/api.rb for more information
require 'aruba/api'

# Prepare test environment.
# Build and intall our gem.
# `tau something` command will be executed in test environment.
require File.expand_path("#{File.dirname(__FILE__)}/cukegem.rb")
CukeGem.setup('tau.gemspec')

# Making test project and start server on it
require 'childprocess'
FileUtils::mkdir_p('tmp/sandbox')
server_process = nil
Dir.chdir('tmp/sandbox') do
  FileUtils::rm_rf('servertesting')
  # Create new project. TODO: think what if tau projecter not works correctly
  ChildProcess.build('tau', 'new', 'servertesting').start.wait

  # Run server on test project directory
  Dir.chdir('servertesting') do
    server_process = ChildProcess.build('tau', 'server')
    server_process.start
  end
end

SANDBOX_PROJECT_DIR = File.expand_path('tmp/sandbox/servertesting')

at_exit do
  server_process.stop
end
