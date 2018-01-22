module FrancisCms
  class AuthorAvatarUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/avatars/#{model.author_name.parameterize}"
    end

    version :small do
      process manipulate_author_avatar: 'x60'
    end

    version :large do
      process manipulate_author_avatar: 'x80'
    end

    private

    # rubocop:disable Metrics/MethodLength
    def manipulate_author_avatar(geometry)
      manipulate! do |img|
        img.strip

        img.combine_options do |c|
          c.interlace 'plane'
          c.quality 72
          c.resize geometry
          c.unsharp 1
        end

        img = yield(img) if block_given?
        img
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
