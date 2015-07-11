module FrancisCms
  class PostInput
    def initialize(params)
      @params = params
    end

    def to_h
      Hash[
        attribute_keys.zip(@params.fetch(:post, {}).values_at(*attribute_keys))
      ]
    end

    private

    def attribute_keys
      [:title, :slug, :body, :excerpt, :tag_list, :is_draft]
    end
  end
end
