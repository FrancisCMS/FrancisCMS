require 'rails_helper'

module FrancisCms
  RSpec.describe Webmention, type: :model do
    describe '#create_webmention_entry' do
      it 'creates an associated webmention entry' do
        webmention = create :webmention
        expect { webmention.create_webmention_entry({}) }
          .to change { webmention.webmention_entry.present? }
          .from(false).to(true)
      end
    end

    describe '#destroy_webmention_entry' do
      it 'destroys the associated webmention entry' do
        webmention = create :webmention
        create :webmention_entry, webmention: webmention
        expect { webmention.destroy_webmention_entry }
          .to change { webmention.reload.webmention_entry.present? }
          .from(true).to(false)
      end
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
