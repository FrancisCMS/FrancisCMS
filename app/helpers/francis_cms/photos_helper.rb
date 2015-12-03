module FrancisCms::PhotosHelper
  def link_to_openstreetmap(photo, html_options = {})
    link_to %{https://www.openstreetmap.org/#map=15/#{photo.latitude}/#{photo.longitude}}, html_options do
      raw %{<span class="p-locality">#{photo.city}</span>, }.tap { |out|
        if photo.country_code == 'US'
          out << %{<abbr class="p-region" title="#{photo.state}">#{photo.state_code}</abbr>}
        else
          out << %{<span class="p-region">#{photo.state}</span>, <span class="p-country-name">#{photo.country}</span>}
        end
      }
    end
  end
end
