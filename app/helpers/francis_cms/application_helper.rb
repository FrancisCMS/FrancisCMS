module FrancisCms::ApplicationHelper
  def author_avatar_image_tag(obj, html_options = {})
    if obj.author_avatar.present?
      raw image_tag(obj.author_avatar_url(:small), html_options.merge({ srcset: %{#{asset_path obj.author_avatar_url(:large)} 2x} }))
    else
      raw image_tag(%{data:image/png;base64,#{Base64.encode64 Rails.application.assets['avatar.png'].to_s}}, html_options)
    end
  end
end
