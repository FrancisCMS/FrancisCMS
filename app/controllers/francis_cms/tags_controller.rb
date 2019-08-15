require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class TagsController < FrancisCmsController
    def index
      grouped_tags

      @total_tags = tags.length
    end

    def show
      @results = (tagged_links + tagged_photos + tagged_posts).sort_by { |result| result[sort_by] }.reverse
    end

    private

    def grouped_tags
      @grouped_tags ||= tags.group_by { |tag| tag.name.downcase[0] }
    end

    def sort_by
      __logged_in__ ? :created_at : :published_at
    end

    def tags
      @tags ||= ActsAsTaggableOn::Tag.all.order('lower(name) ASC')
    end

    def tag
      @tag ||= ActsAsTaggableOn::Tag.friendly.find(params[:id])
    end

    def tagged_links
      return Link.tagged_with(tag) if __logged_in__

      Link.tagged_with(tag).exclude_drafts
    end

    def tagged_photos
      return Photo.tagged_with(tag) if __logged_in__

      Photo.tagged_with(tag).exclude_drafts
    end

    def tagged_posts
      return Post.tagged_with(tag) if __logged_in__

      Post.tagged_with(tag).exclude_drafts
    end
  end
end
