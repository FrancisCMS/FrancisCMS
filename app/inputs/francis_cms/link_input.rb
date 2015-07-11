module FrancisCms
  class LinkInput
    include FrancisCms::Input

    private

    def attribute_keys
      [:url, :title, :body, :tag_list, :is_draft]
    end

    def resource_type_key
      :link
    end
  end
end
