# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "vimo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "vimo"
  s.version     = Vimo::VERSION
  s.authors     = ["Jose Galisteo"]
  s.email       = ["ceritium@gmail.com"]
  s.homepage    = "https://github.com/ceritium/vimo"
  s.summary     = "Allow to your users create and customize their own virtual
  models"
  s.license = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "kaminari"
  s.add_dependency "responders"
  s.add_dependency "paginate-responder"

  s.add_development_dependency "rubocop-rails_config"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "spring"
  s.add_development_dependency "spring-commands-m"
  s.add_development_dependency "m"
end
