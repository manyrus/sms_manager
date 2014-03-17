module SmsManager
  module Core
    class Config
      attr_accessor :from, :is_test

      def initialize
        @is_test = false
        yield self
      end

      def is_test?
        @is_test
      end
    end
  end
end
