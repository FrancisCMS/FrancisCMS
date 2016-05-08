# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

Mime::Type.unregister(:rss)
Mime::Type.register 'application/xml', :rss
Mime::Type.register 'text/markdown', :md
