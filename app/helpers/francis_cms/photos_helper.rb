module FrancisCms
  module PhotosHelper
    # rubocop:disable Rails/OutputSafety
    def link_to_openstreetmap(photo, html_options = {})
      link_to %(https://www.openstreetmap.org/#map=15/#{photo.latitude}/#{photo.longitude}), html_options do
        out = ''

        out << %(<span class="p-locality">#{photo.city}</span>) if photo.city
        out << %(, <span class="p-region">#{photo.state}</span>) if photo.state
        out << %(, <span class="p-country-name">#{photo.country}</span>) if photo.country

        raw out
      end
    end
    # rubocop:enable Rails/OutputSafety
  end
end
