require 'rails_helper'
require 'models/shared/taggable'

module FrancisCms
  RSpec.describe Link, type: :model do
    include_examples 'taggable' do
      let(:model) { create :link }
    end

    describe '#embed_code' do
      context 'youtube link' do
        it 'returns an iframe embed code for youtube.com link' do
          link = create :link, url: 'https://www.youtube.com/watch?v=Vcn9FJCEI1U'
          expect(link.embed_code).to eq(
            '<iframe src="https://www.youtube.com/embed/Vcn9FJCEI1U" ' \
                'allowfullscreen title="YouTube video player"></iframe>'
          )
        end

        it 'returns an iframe embed code for youtu.be link' do
          link = create :link, url: 'https://youtu.be/Vcn9FJCEI1U'
          expect(link.embed_code).to eq(
            '<iframe src="https://www.youtube.com/embed/Vcn9FJCEI1U" ' \
                'allowfullscreen title="YouTube video player"></iframe>'
          )
        end
      end

      context 'vimeo link' do
        it 'returns an iframe embed code for the link' do
          link = create :link, url: 'https://www.vimeo.com/example'
          expect(link.embed_code).to eq(
            '<iframe src="https://player.vimeo.com/video/example" ' \
              'allowfullscreen title="Vimeo video player"></iframe>'
          )
        end
      end
    end
  end
end
