module FrancisCMS
  module Concerns
    module Redcarpeted
      extend ActiveSupport::Concern

      class HTMLRenderer < Redcarpet::Render::HTML
        include Redcarpet::Render::SmartyPants
      end

      module ClassMethods
        def redcarpet(field)
          define_method :to_html do
            extensions = {
              no_intra_emphasis: true,
              space_after_headers: true,
              strikethrough: true
            }

            Redcarpet::Markdown.new(HTMLRenderer, extensions).render(read_attribute(field))
          end
        end
      end
    end
  end
end