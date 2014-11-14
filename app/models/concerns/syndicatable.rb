module FrancisCMS
  module Concerns
    module Syndicatable
      extend ActiveSupport::Concern

      included do
        has_many :syndications, as: :syndicatable, dependent: :destroy

        accepts_nested_attributes_for :syndications
      end
    end
  end
end