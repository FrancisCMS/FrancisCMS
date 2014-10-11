module FrancisCMS
  module Concerns
    module Publishable
      extend ActiveSupport::Concern

      included do
        attr_accessor :published

        before_save :set_published_at
      end

      private

      def set_published_at
        if self.published.to_bool
          if !published_at?
            self.published_at = Time.now
          end
        else
          self.published_at = nil
        end
      end
    end
  end
end