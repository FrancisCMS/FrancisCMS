module FrancisCms
  class WebmentionValidator < ActiveModel::Validator
    def validate(record)
      if record.source.sub(/^https?:\/\//, '') == record.target.sub(/^https?:\/\//, '')
        record.errors[:base] << 'Webmention source and target must be different.'
      end
    end
  end
end
