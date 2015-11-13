module FrancisCms
  class PhotoInput
    include FrancisCms::Input

    private

    def attribute_keys
      [:photo, :photo_cache, :body, :tag_list, :is_draft]
    end

    def resource_type_key
      :photo
    end
  end
end
