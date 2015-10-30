require 'acts-as-taggable-on'
require 'friendly_id'
require 'mechanize'
require 'microformats2'
require 'redcarpet'
require 'will_paginate'

module FrancisCms
  def configuration
    Rails.application.config.francis_cms
  end
  module_function :configuration
end

require 'francis_cms/engine'
