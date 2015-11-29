module FrancisCms
  class Photo < ActiveRecord::Base
    include FrancisCms::Concerns::Models::Publishable
    include FrancisCms::Concerns::Models::Redcarpeted
    include FrancisCms::Concerns::Models::Syndicatable
    include FrancisCms::Concerns::Models::Taggable
    include FrancisCms::Concerns::Models::Webmentionable

    validates :photo, presence: true

    mount_uploader :photo, PhotoUploader

    before_save :extract_exif_data

    redcarpet :body

    self.per_page = 20

    def title
      @title ||= body? ? body.lines.first.chomp : 'Untitled'
    end

    private

    def convert_coords_to_decimal(str, ref)
      if str && ref
        parts = str.split(', ')

        out = to_fraction(parts[0]) + (to_fraction(parts[1]) / 60) + (to_fraction(parts[2]) / 3600)

        if (ref == 'S' || ref == 'W')
          out = out * -1
        end

        out
      end
    end

    def extract_exif_data
      img = MiniMagick::Image.open(photo.path)

      self.latitude = convert_coords_to_decimal(img.exif['GPSLatitude'], img.exif['GPSLatitudeRef'])
      self.longitude = convert_coords_to_decimal(img.exif['GPSLongitude'], img.exif['GPSLongitudeRef'])
    end

    def to_fraction(str)
      numerator, denominator = str.split('/').map(&:to_f)
      denominator ||= 1

      numerator / denominator
    end
  end
end
