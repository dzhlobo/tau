require 'tau/config'

module Tau
  class Projecter
    def self.new_project(parent_directory, project_name)
      Dir.chdir(parent_directory)

      raise "This already is the project directory" if project_dir?(parent_directory)
      raise "Wrong project name" unless project_name =~ PROJECT_NAME_EXP
      raise "Directory exists" if Dir.exist?(project_name)

      Dir.mkdir(project_name)
      Dir.chdir(project_name) do
        create_dir(CODE_DIR)
        create_dir(CODE_DIR, 'js')
        create_dir(CODE_DIR, 'css')
        create_dir(CODE_DIR, 'img')
        create_file(CONFIG_FILE)
      end
    end

    def self.project_dir?(directory)
      Dir.chdir(directory)
      Dir.exist?(CODE_DIR) and File.exist?(CONFIG_FILE)
    end

  private

    def self.create_dir(*directory)
      directory = File.join directory

      Dir.mkdir(directory)
      puts("\tcreate\t#{directory}")
    end

    def self.create_file(*filename)
      filename = File.join filename

      File.new(filename, 'w')
      puts("\tcreate\t#{filename}")
    end
  end
end
