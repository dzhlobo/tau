require 'tau/projecter'
require 'tau/enginer'

module Tau
  class Builder
    def self.build
      raise "You are not in the project directory" unless Projecter.project_dir?(Dir.pwd)

      FileUtils.rm_rf(BUILD_DIR)
      Dir["#{CODE_DIR}/**/*"].each do |filename|
        if File.directory?(filename)
          FileUtils.mkdir_p destination_for(filename)
        elsif Enginer.can_render_from? filename
          engine = Enginer.engine_for_render_from filename
          File.write destination_for(filename, engine), engine.render_file(filename)
        else
          FileUtils.cp filename, destination_for(filename)
        end
      end
    end

  private

    def self.destination_for(filename, engine = nil)
      filename = engine.dst_for filename if engine != nil
      filename.sub(CODE_DIR, BUILD_DIR)
    end
  end
end
