require 'rails_helper'
require 'models/shared/taggable'

module FrancisCms
  RSpec.describe Photo, type: :model do
    include_examples 'taggable' do
      let(:model) { create :photo }
    end
  end

  describe '#convert_coords_to_decimal' do
    it 'converts a coordinate string to decimal' do
      photo = create :photo
      allow(Geocoder).to receive(:search)
      conversion = photo.send(
        :convert_coords_to_decimal,
        '37.5842, -76.1784, 0',
        'W'
      )
      expect(conversion).to eq(-36.31456)
    end
  end

  describe '#reverse_geocode' do
    it 'adds geolocation data to photo' do
      photo = create :photo
      mock_geocoder_search = double({
        street_address: 'street_address',
        city: 'city',
        state: 'state',
        state_code: 'state_code',
        postal_code: 'postal_code',
        country: 'country',
        country_code: 'country_code',
        first: true
      })
      allow(Geocoder).to receive(:search).and_return(mock_geocoder_search)
      expect { photo.send(:reverse_geocode) }
        .to change { photo.street_address }
        .and change { photo.city }
        .and change { photo.state }
        .and change { photo.state_code }
        .and change { photo.postal_code }
        .and change { photo.country }
        .and change { photo.country_code }
    end
  end
end
