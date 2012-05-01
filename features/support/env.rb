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
