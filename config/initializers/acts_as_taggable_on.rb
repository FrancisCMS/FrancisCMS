ActsAsTaggableOn::Tag.class_eval do
  extend FriendlyId

  friendly_id :name,
              use: :slugged,
              slug_column: :slug,
              reserved_words: ['atom', 'create', 'destroy', 'edit', 'rss', 'show', 'update']
end