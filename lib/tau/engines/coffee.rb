require 'tau/engines/abstract_engine'
require 'coffee-script'

module Tau
  module Engines
    class Coffee < AbstractEngine
      render_to 'js'
      from 'coffee'

      def self.render(content)
        CoffeeScript.compile(content)
      end
    end
  end
end
