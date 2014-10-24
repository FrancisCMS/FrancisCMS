module FrancisCMS
  module Concerns
    module Webmentionable
      extend ActiveSupport::Concern

      included do
        has_many :webmentions, as: :webmentionable, dependent: :destroy
      end
    end
  end
end