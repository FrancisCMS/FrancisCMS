module FrancisCMS
  module Concerns
    module Publishable
      extend ActiveSupport::Concern

      included do
        attr_accessor :is_draft

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

        def entries_for_page(options = {})
          opts = { include_drafts: false, page: 1 }.merge(options)

          if opts[:include_drafts]
            page(opts['page'])
          else
            exclude_drafts.page(opts['page']).order('published_at DESC')
          end
        end
      end

      private

      def set_published_at
        if self.is_draft.to_bool
          self.published_at = nil
        else
          self.published_at ||= Time.now
        end
      end
    end
  end
end