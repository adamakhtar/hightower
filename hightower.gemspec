$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hightower/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hightower"
  s.version     = Hightower::VERSION
  s.authors     = ["Adam Akhtar"]
  s.email       = ["adam.akhtar@gmail.com"]
  s.homepage    = "https://github.com/robodisco/hightower"
  s.summary     = "Interact with your users when they behave a certain way"
  s.description = "Track how your users use your application and trigger actions based on predefined behaviour."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "kaminari", "~> 0.16.0"

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'capybara', '~> 2.4.0'
  s.add_development_dependency 'devise'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'rspec-rails', '~> 3'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'sqlite3'
end
