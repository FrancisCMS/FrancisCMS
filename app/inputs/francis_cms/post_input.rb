module FrancisCms
  class PostInput
    include FrancisCms::Input

    private

    def attribute_keys
      [:title, :slug, :body, :excerpt, :tag_list, :is_draft]
    end

    def resource_type_key
      :post
    end
  end
end
