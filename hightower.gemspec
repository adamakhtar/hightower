$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hightower/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hightower"
  s.version     = Hightower::VERSION
  s.authors     = ["Adam Akhtar"]
  s.email       = ["adam.akhtar@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Hightower."
  s.description = "TODO: Description of Hightower."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
end
