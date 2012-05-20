require 'tau/engines/abstract_engine'
require 'sass'

module Tau
  module Engines
    class Scss < AbstractEngine
      render_to 'css'
      from 'scss'

      def self.render(content)
        ::Sass::Engine.new(content, syntax: :scss).render
      end
    end
  end
end
