require 'tau/engines/abstract_engine'
require 'haml'

module Tau
  module Engines
    class Haml < AbstractEngine
      render_to 'html'
      from 'haml'

      def self.render(content)
        ::Haml::Engine.new(content).render
      end
    end
  end
end
