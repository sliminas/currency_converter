module CurrencyConverter

  class Money

    class << self

      def conversion_rates(currency = nil, target_currency_rates = {})
        @conversion_rates ||= {}
        return @conversion_rates if currency.nil?

        (@conversion_rates[currency] ||= {}).merge!(target_currency_rates)
      end

    end

    class MissingConversionRate < StandardError

      def initialize(currency, target_currency)
        super("Missing conversion rate from '#{currency}' to '#{target_currency}'")
      end

    end

    attr_accessor :amount, :currency

    def initialize(amount, currency_string)
      @amount = amount
      @currency = currency_string
    end

    def convert_to(target_currency)
      return self.dup if currency == target_currency

      conversion_rate = conversion_rate(currency, target_currency)

      if conversion_rate.nil?
        # have a look at the other direction of conversion, we can use the reciprocal value then
        conversion_rate = conversion_rate(target_currency, currency)
        conversion_rate = 1 / conversion_rate if conversion_rate
      end

      # we can't convert without conversion rate
      raise MissingConversionRate.new(currency, target_currency) if conversion_rate.nil?

      self.class.new(amount * conversion_rate, target_currency)
    end

    def +(other)
      self.class.new(amount + converted_amount(other), currency)
    end

    def -(other)
      self.class.new(amount - converted_amount(other), currency)
    end

    def *(factor)
      self.class.new(amount * factor, currency)
    end

    def /(divisor)
      self.class.new(amount / divisor.to_f, currency)
    end

    def ==(other)
      (self <=> other) == 0
    end

    def >(other)
      (self <=> other) > 0
    end

    def <(other)
      (self <=> other) < 0
    end

    def <=>(other)
      amount.round(2) <=> converted_amount(other).round(2)
    end

    def inspect
      "%.2f #{currency}" % amount
    end

    private

    def conversion_rate(currency, target_currency)
      target_rates = self.class.conversion_rates[currency]
      target_rates[target_currency]&.to_f if target_rates
    end

    # returns amount of other money object in currency of self
    def converted_amount(other)
      (currency == other.currency ? other : other.convert_to(currency)).amount.to_f
    end

  end

end
