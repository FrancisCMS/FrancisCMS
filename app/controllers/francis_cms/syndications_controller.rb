require_dependency 'francis_cms/francis_cms_controller'

module FrancisCms
  class SyndicationsController < FrancisCmsController
    before_action :require_login

    def create
      save_syndication(SyndicationInput.new(params).to_h)

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def destroy
      syndication.destroy

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable), notice: t('flashes.syndications.destroy_notice')
    end

    def flickr
      begin
        photo_title = syndicatable.title
        photo_description = "#{syndicatable.to_html.lines[1..-1].join.chomp}\n\nOriginally published at #{photo_url(syndicatable)}."
        photo_tags = syndicatable.tags.collect { |tag| %{"#{tag}"} }.join(' ')

        flickr_photo_id = Flickr.upload(syndicatable.photo.path, title: photo_title, description: photo_description, tags: photo_tags)
        flickr_photo_url = "https://www.flickr.com/photos/#{Flickr.photos.find(flickr_photo_id).get_info!.owner.username}/#{flickr_photo_id}/"

        save_syndication({ name: 'Flickr', url: flickr_photo_url })
      rescue
        flash[:alert] = t('flashes.syndications.flickr_create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def medium
      begin
        canonical_url = send("#{resource_type.singularize}_url", syndicatable)

        options = {
          title: syndicatable.title,
          content_format: 'html',
          content: %{<h1>#{syndicatable.title}</h1>#{syndicatable.to_html}<hr><p><i>This post was originally published on <a href="#{canonical_url}" rel="canonical">my own site</a>.</i></p>},
          canonical_url: canonical_url,
          license: 'cc-40-by-nc-sa'
        }

        if syndicatable.tags.any?
          options[:tags] = syndicatable.tags[0..2].collect { |tag| tag.name }
        end

        response = MediumClient.posts.create(MediumClient.users.me, options)

        medium_url = JSON.parse(response.body)['data']['url']

        save_syndication({ name: 'Medium', url: medium_url })
      rescue
        flash[:alert] = t('flashes.syndications.medium_create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    def twitter
      begin
        url = syndicatable.is_link? ? syndicatable.url : send("#{resource_type.singularize}_url", syndicatable)
        options = {}

        if syndicatable.try(:geolocated?) && syndicatable.geolocated?
          places = TwitterClient.reverse_geocode({ lat: syndicatable.latitude, long: syndicatable.longitude })

          if places.any?
            options[:place] = places.first
          end
        end

        if syndicatable.is_photo?
          status = syndicatable.title.truncate(90, omission: '…', separator: ' ')
          tweet = TwitterClient.update_with_media("#{status} – #{url}", File.new(syndicatable.photo.path), options)
        else
          status = syndicatable.title.truncate(114, omission: '…', separator: ' ')
          tweet = TwitterClient.update("#{status} – #{url}", options)
        end

        tweet_url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"

        save_syndication({ name: 'Twitter', url: tweet_url })
      rescue
        flash[:alert] = t('flashes.syndications.twitter_create_alert')
      end

      redirect_to send("edit_#{resource_type.singularize}_path", syndicatable)
    end

    private

    def parent_class
      @parent_class ||= "FrancisCms::#{resource_type.classify}".constantize
    end

    def save_syndication(params)
      @syndication = syndicatable.syndications.new(params)

      if @syndication.save
        flash[:notice] = t('flashes.syndications.create_notice')
      else
        flash[:alert] = t('flashes.syndications.create_alert')
      end
    end

    def syndicatable
      @syndicatable ||= parent_class.find(params["#{resource_type.singularize}_id"])
    end

    def syndication
      @syndication ||= Syndication.find(params[:id])
    end
  end
end
