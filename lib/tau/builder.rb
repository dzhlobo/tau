require 'tau/projecter'
require 'tau/renderer'

module Tau
  class Builder
    class << self

      def build
        raise "You are not in the project directory" unless Projecter.project_dir?(Dir.pwd)

        FileUtils.rm_rf('build')
        Dir['code/**/*'].each do |filename|
          if File.directory?(filename)
            FileUtils.mkdir_p filename.sub('code/', 'build/')
          elsif not Renderer.need_render? filename
            FileUtils.cp filename, destination_for(filename)
          else
            Renderer.render_to_file destination_for(filename), filename
          end
        end
      end

    private

      def destination_for(filename)
        filename.sub('code/', 'build/').sub(/\.sass$/, '.css')
                                       .sub(/\.scss$/, '.css')
                                       .sub(/\.haml$/, '.html')
                                       .sub(/\.coffee$/, '.js')
      end

    end
  end
end
