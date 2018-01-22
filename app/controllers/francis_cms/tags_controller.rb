require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class TagsController < FrancisCmsController
    def index
      grouped_tags

      @total_tags = tags.length
    end

    # rubocop:disable Metrics/MethodLength
    def show
      if __logged_in__
        links = Link.tagged_with(tag)
        photos = Photo.tagged_with(tag)
        posts = Post.tagged_with(tag)

        sort_by = :created_at
      else
        links = Link.tagged_with(tag).exclude_drafts
        photos = Photo.tagged_with(tag).exclude_drafts
        posts = Post.tagged_with(tag).exclude_drafts

        sort_by = :published_at
      end

      @results = (links + photos + posts).sort_by { |result| result[sort_by] }.reverse
    end
    # rubocop:enable Metrics/MethodLength

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
