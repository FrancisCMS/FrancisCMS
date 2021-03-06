module FrancisCms
  class WebmentionValidator < ActiveModel::Validator
    def validate(record)
      record.errors[:base] << 'Webmention source and target must be different.' if source_is_target?(record)
    end

    private

    def source_is_target?(record)
      record.source.sub(%r{^https?://}, '') == record.target.sub(%r{^https?://}, '')
    end
  end
end
