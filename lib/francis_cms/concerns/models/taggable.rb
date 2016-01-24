module FrancisCms::Concerns::Models::Taggable
  extend ActiveSupport::Concern

  included do
    acts_as_taggable
  end

  def sorted_tags
    tags.sort_by { |tag| tag.name.downcase }
  end
end
