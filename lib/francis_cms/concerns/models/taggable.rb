module FrancisCms::Concerns::Models::Taggable
  extend ActiveSupport::Concern

  included do
    acts_as_taggable
  end
end