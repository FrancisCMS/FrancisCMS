lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require 'francis_cms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.required_ruby_version = ['>= 2.2.4', '< 2.6']

  spec.name        = 'francis_cms'
  spec.version     = FrancisCms::VERSION
  spec.authors     = ['Jason Garber']
  spec.email       = ['jason@sixtwothree.org']

  spec.summary     = 'An IndieWeb-friendly content management system.'
  spec.description = "#{spec.summary} FrancisCMS is a mountable engine for use in Rails applications."
  spec.homepage    = 'https://github.com/FrancisCMS/FrancisCMS'
  spec.license     = 'MIT'

  spec.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|spec)/}) }

  # Application
  spec.add_dependency 'rails', '~> 4.2'

  # Database
  spec.add_dependency 'pg', '~> 0.18.4'

  # Utilities
  spec.add_dependency 'acts-as-taggable-on', '~> 3.5'
  spec.add_dependency 'carrierwave', '~> 0.10.0'
  spec.add_dependency 'colored', '~> 1.2'
  spec.add_dependency 'friendly_id', '5.1.0'
  spec.add_dependency 'geocoder', '~> 1.2'
  spec.add_dependency 'mechanize', '~> 2.7'
  spec.add_dependency 'microformats2', '~> 2.0'
  spec.add_dependency 'mini_magick', '~> 4.3'
  spec.add_dependency 'redcarpet', '~> 3.3'
  spec.add_dependency 'rouge', '~> 1.10'
  spec.add_dependency 'will_paginate', '~> 3.0.7'

  # POSSE
  spec.add_dependency 'flickr-objects', '~> 0.6.1'
  spec.add_dependency 'medium-sdk-ruby', '~> 1.0'
  spec.add_dependency 'twitter', '~> 5.16'

  # Development dependencies
  spec.add_development_dependency 'brakeman', '~> 4.1', '>= 4.1.1'
  spec.add_development_dependency 'rubocop', '~> 0.52.1'
end
