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
        img.strip

        img.combine_options do |c|
          c.interlace 'plane'
          c.quality 80
          c.resize %{#{geometry}>}
        end

        img = yield(img) if block_given?
        img
      end
    end
  end
end
