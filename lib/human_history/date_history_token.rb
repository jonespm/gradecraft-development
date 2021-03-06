module HumanHistory
  class DateHistoryToken
    attr_reader :datetime

    def initialize(_, value, _)
      @datetime = value
    end

    def parse(options={})
      { self.class.token => datetime.strftime("%B #{datetime.day.ordinalize}, %Y") }
    end

    class << self
      def token
        :date
      end

      def tokenizable?(key, _, _)
        key == "recorded_at"
      end
    end
  end
end
