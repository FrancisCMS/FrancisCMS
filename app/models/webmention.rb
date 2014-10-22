module FrancisCMS
  module Models
    class Webmention < ActiveRecord::Base
      validates :source, :target, presence: true
      validates :source, format: { :with => URI::regexp(%w(http https)) }
      validates :target, format: { :with => %r{\A#{App.settings.site_url}/?} }

      def verify
        #
      end

      def self.verify_all
        where(verified_at: nil).each(&:verify)
      end
    end
  end
end