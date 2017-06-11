require 'test_helper'

module CurrencyConverter

  class MoneyTest < Minitest::Test

    def setup
      conversion_rates = {
        'USD'     => 1.1196,
        'Bitcoin' => 0.0004
      }
      @fifty_eur = Money.new(50, 'EUR')
      @twenty_usd = Money.new(20, 'USD')

      Money.conversion_rates(
        'EUR',
        conversion_rates
      )
    end

    def test_it_should_have_editable_conversion_rates
      assert_equal(
        {
          'EUR' => {
            'USD'     => 1.1196,
            'Bitcoin' => 0.0004,
          }
        }, Money.conversion_rates
      )

      Money.conversion_rates('EUR', { 'GBP' => 0.8782 })
      assert_equal(
        {
          'EUR' => {
            'USD'     => 1.1196,
            'Bitcoin' => 0.0004,
            'GBP'     => 0.8782
          }
        }, Money.conversion_rates
      )
    end

    def test_it_has_attribute_accessors
      assert_equal 50, @fifty_eur.amount
      assert_equal 'EUR', @fifty_eur.currency
      assert_equal '50.00 EUR', @fifty_eur.inspect
    end

    def test_it_is_convertable
      exception = assert_raises Money::MissingConversionRate do
        @fifty_eur.convert_to('ksaldjf')
      end
      assert_equal "Missing conversion rate from 'EUR' to 'ksaldjf'", exception.message

      assert_equal Money.new(55.98, 'USD'), @fifty_eur.convert_to('USD')
      assert_equal Money.new(50, 'EUR'), @fifty_eur.convert_to('EUR')
      assert_equal Money.new(17.86, 'EUR'), @twenty_usd.convert_to('EUR')
    end

    def test_calculation_in_different_currencies
      assert_equal Money.new(67.86, 'EUR'), @fifty_eur + @twenty_usd
      assert_equal Money.new(32.14, 'EUR'), @fifty_eur - @twenty_usd
      assert_equal Money.new(25.00, 'EUR'), @fifty_eur / 2
      assert_equal Money.new(60, 'USD'), @twenty_usd * 3
    end

    def test_currency_comparison
      assert @twenty_usd == Money.new(20, 'USD')
      assert @twenty_usd != Money.new(30, 'USD')

      fifty_eur_in_usd = @fifty_eur.convert_to('USD')
      assert fifty_eur_in_usd == @fifty_eur

      assert @twenty_usd > Money.new(5, 'USD')
      assert !(@twenty_usd < Money.new(5, 'USD'))
      assert @twenty_usd < @fifty_eur

      assert Money.new(5, 'USD') < @twenty_usd
      assert !(Money.new(5, 'USD') > @twenty_usd)
    end

  end

end
