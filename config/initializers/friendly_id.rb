FriendlyId.defaults do |config|
  config.use :finders
  config.use :reserved
  config.use :slugged

  config.reserved_words = %w(admin assets atom create destroy edit images index javascripts login logout new rss show update session stylesheets users)
end