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
    def preprocess(full_document)
      full_document.gsub(/(?:\n|\A)={3,}(?:\s\[(?<precaption>.*)\])?\r?\n(?<content>.*)?\r?\n={3,}(?:\s\[(?<postcaption>.*)\])?\r?\n/m) do
        "<figure>
          #{render_caption($~[:precaption]) if $~[:precaption]}
          #{MarkupBuilder.new($~[:content].chomp).render}
          #{render_caption($~[:postcaption]) if $~[:postcaption]}
        </figure>"
      end
    end

    private

    def render_caption(markdown)
      "<figcaption>#{MarkupBuilder.new(markdown).render}</figcaption>"
    end
  end

  class MarkupBuilder
    def initialize(markdown)
      @markdown = markdown
    end

    def extensions
      {
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        space_after_headers: true,
        strikethrough: true
      }
    end

    def render
      Redcarpet::Markdown.new(HTMLRenderer, extensions).render(@markdown)
    end
  end
end