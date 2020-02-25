require 'acts-as-taggable-on'
require 'carrierwave'
require 'flickr-objects'
require 'friendly_id'
require 'geocoder'
require 'mechanize'
require 'medium'
require 'microformats2'
require 'mini_magick'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'twitter'
require 'will_paginate'

module FrancisCms
  # rubocop:disable Style/AccessModifierDeclarations
  def configuration
    Rails.application.config.francis_cms
  end
  module_function :configuration
  # rubocop:enable Style/AccessModifierDeclarations
end

require 'francis_cms/engine'
