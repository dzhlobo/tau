module Tau
  class Renderer
    class << self

      def render(content, lang)
        return sass content if lang == :sass
        return scss content if lang == :scss
        return haml content if lang == :haml
        return coffee content if lang == :coffee
      end

      def render_file(filename)
        raise "File is not exist" unless File.exist?(filename)

        content = File.read filename
        return content unless need_render?(filename)
        return sass content if filename.end_with?('.sass')
        return scss content if filename.end_with?('.scss')
        return haml content if filename.end_with?('.haml')
        return coffee content if filename.end_with?('.coffee')
      end

      def render_to_file(dst_filename, filename)
        File.write dst_filename, render_file(filename)
      end

      def need_render?(filename)
        return true if filename.end_with?('.sass') or
                       filename.end_with?('.scss') or
                       filename.end_with?('.haml') or
                       filename.end_with?('.coffee')
        false
      end

    private

      def sass(content)
        Sass::Engine.new(content).render
      end

      def scss(content)
        Sass::Engine.new(content, syntax: :scss).render
      end

      def haml(content)
        Haml::Engine.new(content).render
      end

      def coffee(content)
        CoffeeScript.compile(content)
      end

    end
  end
end
