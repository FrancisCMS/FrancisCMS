module FrancisCms
  class LinkInput
    def initialize(params)
      @params = params
    end

    def to_h
      Hash[
        attribute_keys.zip(@params.fetch(:link, {}).values_at(*attribute_keys))
      ]
    end

    private

    def attribute_keys
      [:url, :title, :body, :tag_list, :is_draft]
    end
  end
end
