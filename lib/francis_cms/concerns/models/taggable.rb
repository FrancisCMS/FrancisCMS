module FrancisCms::Concerns::Models::Taggable
  extend ActiveSupport::Concern

  included do
    acts_as_ordered_taggable
  end
end
