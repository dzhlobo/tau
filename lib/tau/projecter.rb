module Tau
  class Projecter
    def self.new_project(directory, project_name)
      Dir.chdir(directory)

      raise "This already is the project directory" if project_dir?(directory)
      raise "Wrong project name" unless project_name =~ /^\w+$/
      raise "Directory exists" if Dir.exist?(project_name)

      Dir.mkdir(project_name)
      Dir.chdir(project_name) do
        Dir.mkdir('code')
        Dir.mkdir('code/js')
        Dir.mkdir('code/css')
        Dir.mkdir('code/img')
        File.new('tau.yaml', 'w')
      end
    end

    def self.project_dir?(directory)
      Dir.chdir(directory)
      Dir.exist?('code') and File.exist?('tau.yaml')
    end
  end
end
