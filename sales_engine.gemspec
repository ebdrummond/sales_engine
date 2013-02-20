lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |gem|
  gem.name          = "sales_engine"
  gem.version       = "0.0.1"
  gem.authors       = ["Erin Drummond", "Shane Rogers"]
  gem.email         = ["e.b.drummond@gmail.com", "rogerssh@tcd.ie"]
  gem.description   = %q{gSchool project - SalesEngine}
  gem.summary       = %q{gSchool project - SalesEngine}
  gem.homepage      = "https://github.com/ebdrummond/sales_engine.git"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
