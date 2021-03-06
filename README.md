# CurrencyConverter

Convertion and calculation of money amounts in different currencies.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'currency_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install currency_converter

## Usage

Configure the conversion rates:
```ruby
CurrencyConverter::Money.conversion_rates(
  'EUR',
  {
    'USD'     => 1.1196,
    'Bitcoin' => 0.0004
  }
)
```

Then have fun with your money:
```ruby
fifty_eur = CurrencyConverter::Money.new(50, 'EUR')
twenty_usd = CurrencyConverter::Money.new(20, 'USD')
fifty_eur.amount                # => 50
fifty_eur.currency              # => 'EUR'
twenty_usd.convert_to('EUR')    # => 17.86 (Money object)
fifty_eur + twenty_usd          # => 67.86 EUR (Money object)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/currency_converter.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

