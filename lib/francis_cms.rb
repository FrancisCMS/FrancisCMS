require 'acts-as-taggable-on'
require 'carrierwave'
require 'flickr-objects'
require 'friendly_id'
require 'geocoder'
require 'mechanize'
require 'microformats2'
require 'mini_magick'
require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'will_paginate'

module FrancisCms
  def configuration
    Rails.application.config.francis_cms
  end
  module_function :configuration
end

require 'francis_cms/engine'
