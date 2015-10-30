module FrancisCms
  class AuthorAvatarUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      %{uploads/avatars/#{model.author_name.parameterize}}
    end

    version :small do
      process :manipulate_author_avatar => 'x60'
    end

    version :large do
      process :manipulate_author_avatar => 'x80'
    end

    private

    def manipulate_author_avatar(geometry)
      manipulate! do |img|
        img.interlace('Plane')
        img.quality(72)
        img.resize(geometry)
        img.strip
        img.unsharp(1)

        img = yield(img) if block_given?
        img
      end
    end
  end
end
