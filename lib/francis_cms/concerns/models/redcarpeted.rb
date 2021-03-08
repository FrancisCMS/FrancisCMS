module FrancisCms
  module Concerns
    module Models
      module Redcarpeted
        extend ActiveSupport::Concern

        module ClassMethods
          def redcarpet(field)
            define_method :to_html do
              MarkupBuilder.new(read_attribute(field)).render
            end
          end
        end

        class HTMLRenderer < Redcarpet::Render::SmartyHTML
          include Rouge::Plugins::Redcarpet

          def preprocess(full_document)
            render_figure(full_document)
          end

          private

          def render_figcaption(markdown)
            "<figcaption>#{MarkupBuilder.new(markdown).render}</figcaption>"
          end

          def render_figure(markdown)
            markdown.gsub(/(?:\n|\A)={3,}(?:\s\[(?<precaption>.*)\])?\r?\n(?<content>.*)?\r?\n={3,}(?:\s\[(?<postcaption>.*)\])?\r?\n/m) do
              "<figure>
                #{render_figcaption($LAST_MATCH_INFO[:precaption]) if $LAST_MATCH_INFO[:precaption]}
                #{MarkupBuilder.new($LAST_MATCH_INFO[:content].chomp).render}
                #{render_figcaption($LAST_MATCH_INFO[:postcaption]) if $LAST_MATCH_INFO[:postcaption]}
              </figure>"
            end
          end
        end

        class MarkupBuilder
          def initialize(markdown)
            @markdown = markdown
          end

          def extensions
            {
              fenced_code_blocks:  true,
              no_intra_emphasis:   true,
              space_after_headers: true,
              strikethrough:       true
            }
          end

          def render
            Redcarpet::Markdown.new(HTMLRenderer, extensions).render(@markdown)
          end
        end
      end
    end
  end
end
