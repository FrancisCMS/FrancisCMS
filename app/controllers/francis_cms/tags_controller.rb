require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class TagsController < FrancisCmsController
    def index
      tags
    end

    def show
      tag

      posts = Post.tagged_with(@tag).exclude_drafts
      links = Link.tagged_with(@tag).exclude_drafts
      @results = (posts + links).sort_by { |result| result[:published_at] }.reverse

      if __logged_in__
        posts = Post.tagged_with(@tag)
        links = Link.tagged_with(@tag)
        @results = (posts + links).sort_by { |result| result[:created_at] }.reverse
      end
    end

    private

    def tags
      @tags ||= ActsAsTaggableOn::Tag.all.order('name ASC').group_by { |tag| tag.name[0] }
    end

    def tag
      @tag ||= ActsAsTaggableOn::Tag.friendly.find(params[:id])
    end
  end
end
