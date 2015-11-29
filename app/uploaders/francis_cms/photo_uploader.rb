module FrancisCms
  class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      %{uploads/photos/#{model.id}}
    end

    def extension_white_list
      %w(gif jpeg jpg png)
    end

    version :small do
      process :manipulate_photo => '500x500'
    end

    version :medium do
      process :manipulate_photo => '750x750'
    end

    version :large do
      process :manipulate_photo => '1000x1000'
    end

    private

    def manipulate_photo(geometry)
      manipulate! do |img|
        img.interlace('Plane')
        img.quality(80)
        img.resize(%{#{geometry}>})
        img.strip

        img = yield(img) if block_given?
        img
      end
    end
  end
end
