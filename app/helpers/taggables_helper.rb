module FrancisCMS
  module Helpers
    module TaggablesHelper
      def generate_taggable_params(original_params)
        original_params.tap do |og_params|
          if og_params.has_key?(:tag_list)
            tag_names = og_params[:tag_list].split(',').collect { |name| name.strip }

            og_params[:tag_ids] = tag_names.map { |name| Tag.find_or_create_by(name: name).id }
          end
        end
      end
    end
  end
end