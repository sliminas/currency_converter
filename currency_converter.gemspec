$:.push File.expand_path('../lib', __FILE__)
require 'currency_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'currency_converter'
  spec.version       = CurrencyConverter::VERSION
  spec.authors       = ['Dawanda Engineering Candidate']
  spec.email         = ['candidate@mail.de']

  spec.summary       = 'Convert money to different currencies'
  spec.description   = 'Convert money to different currencies'
  spec.homepage      = 'http://github.com'
  spec.license       = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  spec.test_files = Dir['test/**/*']

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.10'
end
