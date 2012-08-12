module Tau
  module Defaults
    PORT = 15000
  end

  CODE_DIR = 'code'
  BUILD_DIR = 'build'
  CONFIG_FILE = 'tau.yml'

  PROJECT_NAME_EXP = /^[[:word:]\.-]+$/

  SERVER = %w(thin webrick)

  FILE_PATH_EXP = /^([[:word:]\.-\/]+)$/
end
