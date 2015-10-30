$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'francis_cms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'francis_cms'
  s.version     = FrancisCms::VERSION
  s.authors     = ['Jason Garber']
  s.email       = ['jason@sixtwothree.org']
  s.homepage    = 'https://github.com/jgarber623/FrancisCMS'
  s.summary     = 'An IndieWeb-friendly content management system.'
  s.description = "#{s.summary} FrancisCMS is a mountable engine for use in Rails applications."

  s.files = Dir["{app,config,db,lib}/**/*", 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  # Application
  s.add_dependency 'rails', '~> 4.2.0'

  # Database
  s.add_dependency 'pg'

  # Utilities
  s.add_dependency 'acts-as-taggable-on', '~> 3.5'
  s.add_dependency 'carrierwave'
  s.add_dependency 'friendly_id', '5.1.0'
  s.add_dependency 'mechanize'
  s.add_dependency 'microformats2'
  s.add_dependency 'mini_magick'
  s.add_dependency 'redcarpet'
  s.add_dependency 'will_paginate', '~> 3.0.6'

  # Testing
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'bourne'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'mocha'
end
