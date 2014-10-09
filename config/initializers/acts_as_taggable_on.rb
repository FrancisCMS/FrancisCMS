ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId

  friendly_id :name,
              use: :slugged,
              slug_column: :slug,
              reserved_words: ['create', 'destroy', 'edit', 'show', 'update']
end