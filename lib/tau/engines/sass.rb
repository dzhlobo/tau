require 'tau/engines/abstract_engine'
require 'sass'

module Tau
  module Engines
    class Sass < AbstractEngine
      render_to 'css'
      from 'sass'

      def self.render(content)
        ::Sass::Engine.new(content).render
      end
    end
  end
end
