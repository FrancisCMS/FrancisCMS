module FrancisCms
  class LinkInput
    include FrancisCms::Input

    private

    def attribute_keys
      [:url, :title, :body, :tag_list, :is_draft]
    end

    def type_key
      :link
    end
  end
end
