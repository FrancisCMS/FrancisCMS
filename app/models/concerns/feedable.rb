module FrancisCMS
  module Concerns
    module Feedable
      extend ActiveSupport::Concern

      module ClassMethods
        def recent_items_for_feed(limit = 10)
          limit(limit).order('published_at DESC')
        end
      end
    end
  end
end