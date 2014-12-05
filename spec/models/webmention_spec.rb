require 'rails_helper'

describe Webmention do
  context '#valid?' do
    it 'fails validation if target URL does not begin with site-configured URL.' do
      webmention = Webmention.new source: 'http://example.com/foo', target: 'http://domain.com/bar'

      expect(webmention.valid?).to eql(false)
    end
  end

  context '#author_name' do
    context 'with an h-entry' do
      let :entry { stub(author: stub(format: stub(name: stub(to_s: 'Foo Bar')))) }
      let :webmention { Webmention.new }

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the author name.' do
        expect(webmention.author_name).to eql('Foo Bar')
      end
    end

    context 'with an h-card' do
      let :card { stub(name: stub(to_s: 'Foo Bar')) }
      let :webmention { Webmention.new }

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns card
      end

      it 'returns the author name.' do
        expect(webmention.author_name).to eql('Foo Bar')
      end
    end

    context 'without an h-card or h-entry' do
      let :webmention { Webmention.new source: 'http://example.com/foo/bar' }

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns nil
      end

      it 'returns the source URLs domain in place of the author name.' do
        expect(webmention.author_name).to eql('example.com')
      end
    end
  end

  context '#author_photo' do
    context 'with an h-entry' do
      let :entry { stub(author: stub(format: stub(photo: stub(to_s: '/foo.png')))) }

      let :webmention { Webmention.new source: 'http://example.com/bar' }

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the author photo.' do
        expect(webmention.author_photo).to eql('http://example.com/foo.png')
      end
    end

    context 'with an h-card' do
      let :card { stub(photo: stub(to_s: '/foo.png')) }
      let :webmention { Webmention.new source: 'http://example.com/bar' }

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns card
      end

      it 'returns the author photo.' do
        expect(webmention.author_photo).to eql('http://example.com/foo.png')
      end
    end

    context 'without an h-card or h-entry' do
      let :webmention { Webmention.new source: 'http://example.com/bar' }

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns nil
      end

      it 'returns the default photo in place of the author photo.' do
        expect(webmention.author_photo).to eql('http://www.placecage.com/150/150')
      end
    end
  end

  context '#author_url' do
    context 'with an h-entry' do
      let :entry { stub(author: stub(format: stub(url: stub(to_s: '/')))) }
      let :webmention { Webmention.new source: 'http://example.com/bar' }

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the author URL.' do
        expect(webmention.author_url).to eql('http://example.com/')
      end
    end

    context 'with an h-card' do
      let :card { stub(url: stub(to_s: '/')) }
      let :webmention { Webmention.new source: 'http://example.com/bar' }

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns card
      end

      it 'returns the author URL.' do
        expect(webmention.author_url).to eql('http://example.com/')
      end
    end

    context 'without an h-card or h-entry' do
      let :webmention { Webmention.new source: 'http://example.com/bar' }

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns nil
      end

      it 'returns the source URL host and domain as the author URL.' do
        expect(webmention.author_url).to eql('http://example.com/')
      end
    end
  end

  context '#entry_url' do
    context 'with an h-entry' do
      let :entry { stub(url: stub(to_s: '/foo')) }
      let :webmention { Webmention.new source: 'http://example.com/foo' }

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the entry URL.' do
        expect(webmention.entry_url).to eql('http://example.com/foo')
      end
    end

    context 'without an h-entry' do
      let :webmention { Webmention.new source: 'http://example.com/foo' }

      before :each do
        webmention.stubs(:entry).returns nil
      end

      it 'returns the source URL in place of the entry URL.' do
        expect(webmention.entry_url).to eql('http://example.com/foo')
      end
    end
  end

  context '#published_at' do
    context 'with an h-entry' do
      let :entry { stub(published: stub(to_s: '2000-01-01T00:00:00')) }
      let :webmention { Webmention.new }

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the date published.' do
        expect(webmention.published_at).to eql(Time.parse '2000-01-01T00:00:00')
      end
    end

    context 'without an h-entry' do
      let :webmention { Webmention.new created_at: Time.parse('2000-01-01T00:00:00') }

      before :each do
        webmention.stubs(:entry).returns nil
      end

      it 'returns the date created in place of the date published.' do
        expect(webmention.published_at).to eql(Time.parse '2000-01-01T00:00:00')
      end
    end
  end
end