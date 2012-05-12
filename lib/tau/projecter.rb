module Tau
  class Projecter
    def self.new_project(directory, project_name)
      Dir.chdir(directory)

      raise "This already is the project directory" if project_dir?(directory)
      raise "Wrong project name" unless project_name =~ /\A[\wа-я-]+[\wа-я]\.?[\wа-я]+?\z/
      raise "Directory exists" if Dir.exist?(project_name)

      Dir.mkdir(project_name)
      Dir.chdir(project_name) do
        puts("\tcreate\tcode")
        Dir.mkdir('code')
        puts("\tcreate\tcode/js")
        Dir.mkdir('code/js')
        puts("\tcreate\tcode/css")
        Dir.mkdir('code/css')
        puts("\tcreate\tcode/img")
        Dir.mkdir('code/img')
        puts("\tcreate\ttau.yaml")
        File.new('tau.yaml', 'w')
      end
    end

    def self.project_dir?(directory)
      Dir.chdir(directory)
      Dir.exist?('code') and File.exist?('tau.yaml')
    end
  end
end
