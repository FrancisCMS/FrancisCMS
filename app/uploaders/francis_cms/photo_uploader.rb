module FrancisCms
  class PhotoUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :file

    def store_dir
      "uploads/photos/#{model.id}"
    end

    def extension_white_list
      %w[gif jpeg jpg png]
    end

    version :small_jpg do
      process mogrify: [{
        format:     'jpg',
        resolution: '500x500'
      }]

      def full_filename(for_file = model.photo.file)
        "#{File.basename(for_file, '.*')}_small.jpg"
      end
    end

    version :medium_jpg do
      process mogrify: [{
        format:     'jpg',
        resolution: '750x750'
      }]

      def full_filename(for_file = model.photo.file)
        "#{File.basename(for_file, '.*')}_medium.jpg"
      end
    end

    version :large_jpg do
      process mogrify: [{
        format:     'jpg',
        resolution: '1000x1000'
      }]

      def full_filename(for_file = model.photo.file)
        "#{File.basename(for_file, '.*')}_large.jpg"
      end
    end

    private

    def mogrify(options = {})
      manipulate! do |img|
        img.strip

        img.format(options[:format]) do |c|
          c.interlace 'plane'
          c.quality 80
          c.resize "#{options[:resolution]}>"
        end

        img
      end
    end
  end
end
