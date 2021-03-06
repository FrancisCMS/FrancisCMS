module FrancisCms
  class SyndicationInput
    include FrancisCms::Input

    private

    def attribute_keys
      [:name, :url]
    end

    def resource_type_key
      :syndication
    end
  end
end
