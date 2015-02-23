require 'rails_helper'

module FrancisCms
  describe Webmention do
    context '#valid?' do
      it 'fails validation if target URL does not begin with site-configured URL.' do
        webmention = Webmention.new source: 'http://example.com/foo', target: 'http://domain.com/bar'

        expect(webmention.valid?).to eql(false)
      end
    end

    context 'creates a webmention entry' do
      let(:webmention) { Webmention.new }

      before :each do
        WebmentionEntry.stubs(:create_from_collection)
      end

      it 'from a collection.' do
        webmention.add_webmention_entry('collection')

        expect(WebmentionEntry).to have_received(:create_from_collection).with(webmention, 'collection')
      end
    end
  end
end
