require 'dish'
class Freshdesk
  module Api

    class Object < ::Dish::Plate
      def self.for(type, data = {})
        case type
        when :ticket
          Ticket.new(data)
        else
          self.new(data)
        end
      end
      def initialize(data = {})
        super
        @json_data
      end
      attr_reader :json_data
    end

    class Ticket < Object      
    end

  end
end
