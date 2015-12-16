module FrancisCms::PhotosHelper
  def link_to_openstreetmap(photo, html_options = {})
    link_to %{https://www.openstreetmap.org/#map=15/#{photo.latitude}/#{photo.longitude}}, html_options do
      out = ''

      if photo.city
        out << %{<span class="p-locality">#{photo.city}</span>}
      end

      if photo.state
        out << %{, <span class="p-region">#{photo.state}</span>}
      end

      if photo.country
        out << %{, <span class="p-country-name">#{photo.country}</span>}
      end

      raw out
    end
  end

  def photo_image_tag(photo, html_options = {})
    raw image_tag(photo.photo.url(:medium), html_options.merge({srcset: %{#{asset_path photo.photo.url(:small)} 500w, #{asset_path photo.photo.url(:medium)} 750w, #{asset_path photo.photo.url(:large)} 1000w}}))
  end
end
