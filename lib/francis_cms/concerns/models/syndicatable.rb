module FrancisCms::Concerns::Models::Syndicatable
  extend ActiveSupport::Concern

  included do
    has_many :syndications, as: :syndicatable, dependent: :destroy
  end
end