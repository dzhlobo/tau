module Tau
  module Engines
    class AbstractEngine
      class << self

        def render_file(filename)
          render File.read(filename)
        end

        def source_exist?(dst)
          File.exist? source_for(dst)
        end

        def source_for(dst)
          dst.sub(/\.#{render_to}\z/, ".#{render_from}")
        end

        def dst_exist?(source)
          File.exist? dst_for(source)
        end

        def dst_for(source)
          source.sub(/\.#{render_from}\z/, ".#{render_to}")
        end

        def can_render_to?(filename)
          filename.end_with?(render_to) and source_exist?(filename)
        end

        def can_render_from?(filename)
          filename.end_with?(render_from) and File.exist?(filename)
        end

      private

        def render_to(format)
          self.instance_eval %{
            def render_to?(format)
              format == "#{format}"
            end

            def render_to
              "#{format}"
            end
          }
        end

        def to(format)
          render_to format
        end

        def render_from(format)
          self.instance_eval %{
            def render_from?(format)
              format == "#{format}"
            end

            def render_from
              "#{format}"
            end
          }
        end

        def from(format)
          render_from format
        end

      end
    end
  end
end
