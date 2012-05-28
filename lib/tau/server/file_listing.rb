require 'haml'

module Tau
  module ServerHelpers
    module FileListing
      def show_list_of_files_on(dirname, error="")
        @title = "Tau: #{url_for dirname}"
        @error = error
        @file_list = list_of_files_on dirname
        view = File.read File.join(File.dirname(__FILE__),'views/file_listing.haml')
        Haml::Engine.new(view).render(self)
      end

      def list_of_files_on(dirname)
        file_list = []
        file_list << up_dir(dirname) unless upper_dir?(dirname)
        Dir.chdir(dirname) do
          Dir['*'].each do |filename|
            file_list << { 
              filename: filename_for(filename),
              type: File.directory?(filename) ? :dir : :file,
              url: url_for(filename) 
            }
          end
        end
        file_list.sort! do |one, another|
          if one[:type] == :up or (one[:type] == :dir and another[:type] != :dir)
            -1
          elsif another[:type] == :up or (one[:type] != :dir and another[:type] == :dir)
            1
          else
            one[:filename] <=> another[:filename]
          end
        end
      end

      def upper_dir?(dirname)
        dirname.end_with?("/code")
      end

      def up_dir(dirname)
        {
          filename: '..',
          type: :up,
          url: url_for(dirname.sub(%r(/[[:word:]\.-]+/?\z), '/'))
        }
      end

      def filename_for(filename)
        Enginer.dst_for filename
      end

      def url_for(filename)
        File.expand_path(Enginer.dst_for filename).sub(%r(\A.*/code/?), '/')
      end
    end
  end
end
