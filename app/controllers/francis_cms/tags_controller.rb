require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class TagsController < FrancisCmsController
    def index
      grouped_tags

      @total_tags = tags.length
    end

    def show
      tag

      links = Link.tagged_with(@tag).exclude_drafts
      photos = Photo.tagged_with(@tag).exclude_drafts
      posts = Post.tagged_with(@tag).exclude_drafts
      @results = (links + photos + posts).sort_by { |result| result[:published_at] }.reverse

      if __logged_in__
        links = Link.tagged_with(@tag)
        photos = Photo.tagged_with(@tag)
        posts = Post.tagged_with(@tag)
        @results = (links + photos + posts).sort_by { |result| result[:created_at] }.reverse
      end
    end

    private

    def grouped_tags
      @grouped_tags ||= tags.group_by { |tag| tag.name.downcase[0] }
    end

    def tags
      @tags ||= ActsAsTaggableOn::Tag.all.order('lower(name) ASC')
    end

    def tag
      @tag ||= ActsAsTaggableOn::Tag.friendly.find(params[:id])
    end
  end
end
