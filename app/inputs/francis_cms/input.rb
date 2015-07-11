module FrancisCms
  module Input
    def initialize(params)
      @params = params.fetch(resource_type_key, {})
    end

    def to_h
      Hash[
        attribute_keys.zip(@params.values_at(*attribute_keys))
      ]
    end
  end
end
