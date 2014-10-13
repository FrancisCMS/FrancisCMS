ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId

  friendly_id :name
end

ActsAsTaggableOn.remove_unused_tags = true