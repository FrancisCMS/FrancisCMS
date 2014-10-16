module FrancisCMS
  module Concerns
    module Publishable
      extend ActiveSupport::Concern

      included do
        attr_accessor :published

        before_save :set_published_at

        scope :exclude_drafts, lambda { where('published_at IS NOT NULL') }
      end

      module ClassMethods
        def recent_items(options = {})
          opts = { include_drafts: false, limit: nil }.merge(options)

          if opts[:include_drafts]
            limit(opts[:limit]).order('created_at DESC')
          else
            exclude_drafts.limit(opts[:limit]).order('published_at DESC')
          end
        end
      end

      def parameterize
        self.class.method_defined?(:slug) ? slug : id.to_s
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