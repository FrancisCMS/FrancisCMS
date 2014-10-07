module HTMLable
  extend ActiveSupport::Concern

  class HTMLRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end

  def to_html
    extensions = {
      no_intra_emphasis: true,
      space_after_headers: true,
      strikethrough: true
    }

    Redcarpet::Markdown.new(HTMLRenderer, extensions).render(body)
  end
end