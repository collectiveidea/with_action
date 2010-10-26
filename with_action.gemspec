# -*- encoding: utf-8 -*-
require File.expand_path("../lib/with_action/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "with_action"
  s.version     = WithAction::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brandon Keepers", "Daniel Morrison"]
  s.email       = ['info@collectiveidea.com']
  s.homepage    = "http://rubygems.org/gems/with_action"
  s.summary     = "A respond_to style helper for Rails controllers for doing different actions based on which request parameters are passed."
  s.description = 'A respond_to style helper for doing different actions based on which request parameters are passed. Specifically, it is helpful if you want to use multiple form buttons on a page, such as "Save", "Save and Continue Editing", and "Cancel".  with_action executes different blocks based on what the presence of request parameters.'

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "with_action"

  s.add_dependency "actionpack"
  
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "mocha"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
