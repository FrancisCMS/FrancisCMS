module FrancisCms
  class PostInput
    include FrancisCms::Input

    private

    def attribute_keys
      [:title, :slug, :body, :excerpt, :tag_list, :is_draft]
    end

    def type_key
      :post
    end
  end
end
