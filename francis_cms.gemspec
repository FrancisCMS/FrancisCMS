$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'francis_cms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'francis_cms'
  s.version     = FrancisCms::VERSION
  s.authors     = ['Jason Garber']
  s.email       = ['jason@sixtwothree.org']
  s.homepage    = 'https://github.com/FrancisCMS/FrancisCMS'
  s.summary     = 'An IndieWeb-friendly content management system.'
  s.description = "#{s.summary} FrancisCMS is a mountable engine for use in Rails applications."

  s.files = Dir["{app,config,db,lib}/**/*", 'Rakefile', 'README.md']

  # Application
  s.add_dependency 'rails', '~> 4.2'

  # Database
  s.add_dependency 'pg', '~> 0.18.4'

  # Utilities
  s.add_dependency 'acts-as-taggable-on', '~> 3.5'
  s.add_dependency 'carrierwave', '~> 0.10.0'
  s.add_dependency 'colored', '~> 1.2'
  s.add_dependency 'friendly_id', '5.1.0'
  s.add_dependency 'geocoder', '~> 1.2'
  s.add_dependency 'mechanize', '~> 2.7'
  s.add_dependency 'microformats2', '~> 2.0'
  s.add_dependency 'mini_magick', '~> 4.3'
  s.add_dependency 'redcarpet', '~> 3.3'
  s.add_dependency 'rouge', '~> 1.10'
  s.add_dependency 'will_paginate', '~> 3.0.7'

  # POSSE
  s.add_dependency 'flickr-objects', '~> 0.6.1'
  s.add_dependency 'medium-sdk-ruby', '~> 1.0'
  s.add_dependency 'twitter', '~> 5.16'

  # Development dependencies
  s.add_development_dependency 'rubocop', '~> 0.42.0'
end
