module FrancisCms
  module Input
    def initialize(params)
      @params = params
    end

    def to_h
      Hash[
        attribute_keys.zip(@params.fetch(type_key, {}).values_at(*attribute_keys))
      ]
    end
  end
end
