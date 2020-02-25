module FrancisCms
  class Photo < ActiveRecord::Base
    include FrancisCms::Concerns::Models::Publishable
    include FrancisCms::Concerns::Models::Redcarpeted
    include FrancisCms::Concerns::Models::Syndicatable
    include FrancisCms::Concerns::Models::Taggable
    include FrancisCms::Concerns::Models::Webmentionable

    validates :photo, presence: true

    mount_uploader :photo, PhotoUploader

    before_save :extract_exif_data, :reverse_geocode

    redcarpet :body

    self.per_page = 20

    def geolocated?
      latitude? && longitude?
    end

    def title
      @title ||= body? ? CGI.unescapeHTML(sanitizer.sanitize(to_html.lines.first.chomp)) : 'Untitled'
    end

    private

    def convert_coords_to_decimal(str, ref)
      return unless str && ref

      parts = str.split(', ')

      out = to_fraction(parts[0]) + (to_fraction(parts[1]) / 60) + (to_fraction(parts[2]) / 3600)

      out *= -1 if %w[S W].include?(ref)

      out
    end

    def extract_exif_data
      img = MiniMagick::Image.open(photo.path)

      self.latitude = extract_latitude(img.exif)
      self.longitude = extract_longitude(img.exif)

      self.taken_at = extract_taken_at(img.exif)
    end

    def extract_latitude(exif)
      convert_coords_to_decimal(exif['GPSLatitude'], exif['GPSLatitudeRef'])
    end

    def extract_longitude(exif)
      convert_coords_to_decimal(exif['GPSLongitude'], exif['GPSLongitudeRef'])
    end

    def extract_taken_at(exif)
      gps_date_stamp = exif['GPSDateStamp']
      gps_time_stamp = exif['GPSTimeStamp']
      date_time_original = exif['DateTimeOriginal']

      if gps_date_stamp && gps_time_stamp
        matches = gps_time_stamp.match(%r{^(?<hours>\d+)\/\d+, (?<minutes>\d+)\/\d+, (?<seconds>\d+)\/\d+$})

        %(#{gps_date_stamp.tr(':', '-')} #{matches[:hours]}:#{matches[:minutes]}:#{matches[:seconds]}).to_datetime
      elsif date_time_original
        DateTime.strptime(date_time_original, '%Y:%m:%d %H:%M:%S')
      end
    end

    def reverse_geocode
      geo = Geocoder.search(%(#{latitude},#{longitude}))

      return unless geo.first

      self.street_address = geo.street_address
      self.city = geo.city
      self.state = geo.state
      self.state_code = geo.state_code
      self.postal_code = geo.postal_code
      self.country = geo.country
      self.country_code = geo.country_code
    end

    def sanitizer
      @sanitizer ||= Rails::Html::FullSanitizer.new
    end

    def to_fraction(str)
      numerator, denominator = str.split('/').map(&:to_f)
      denominator ||= 1

      numerator / denominator
    end
  end
end
