module Skylight
  module Messages
    class Base
      module ClassMethods
        attr_accessor :message_id
      end

      def self.inherited(klass)
        klass.class_eval do
          include Beefcake::Message
          extend  ClassMethods
        end

        klass.message_id = (@count ||= 0)
        @count += 1
      end
    end
  end
end
