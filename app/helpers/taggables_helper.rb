module FrancisCMS
  module Helpers
    module TaggablesHelper
      def generate_taggable_params(original_params)
        original_params.tap do |t|
          tag_names = t[:tag_list].split(',').collect { |name| name.strip }

          t[:tag_ids] = tag_names.map { |name| Tag.find_or_create_by(name: name).id }
        end
      end
    end
  end
end