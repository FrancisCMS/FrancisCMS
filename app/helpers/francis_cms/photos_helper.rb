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

  def photo_picture_tag(photo, html_options = {})
    raw '<picture>'.tap { |out|
      out << %{<source srcset="#{asset_path photo.photo.url(:small_webp)} 500w, #{asset_path photo.photo.url(:medium_webp)} 750w, #{asset_path photo.photo.url(:large_webp)} 1000w" type="image/webp">}
      out << image_tag(photo.photo.url(:medium_jpg), html_options.merge({srcset: %{#{asset_path photo.photo.url(:small_jpg)} 500w, #{asset_path photo.photo.url(:medium_jpg)} 750w, #{asset_path photo.photo.url(:large_jpg)} 1000w}}))
      out << '</picture>'
    }
  end
end