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
      let :entry do
        stub(author: stub(format: stub(name: stub(to_s: 'Foo Bar'))))
      end

      let :webmention do
        Webmention.new
      end

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the author name.' do
        expect(webmention.author_name).to eql('Foo Bar')
      end
    end

    context 'with an h-card' do
      let :card do
        stub(name: stub(to_s: 'Foo Bar'))
      end

      let :webmention do
        Webmention.new
      end

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns card
      end

      it 'returns the author name.' do
        expect(webmention.author_name).to eql('Foo Bar')
      end
    end

    context 'without an h-card or h-entry' do
      let :webmention do
        Webmention.new source: 'http://example.com/foo/bar'
      end

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
      let :entry do
        stub(author: stub(format: stub(photo: stub(to_s: '/foo.png'))))
      end

      let :webmention do
        Webmention.new source: 'http://example.com/bar'
      end

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the author photo.' do
        expect(webmention.author_photo).to eql('http://example.com/foo.png')
      end
    end

    context 'with an h-card' do
      let :card do
        stub(photo: stub(to_s: '/foo.png'))
      end

      let :webmention do
        Webmention.new source: 'http://example.com/bar'
      end

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns card
      end

      it 'returns the author photo.' do
        expect(webmention.author_photo).to eql('http://example.com/foo.png')
      end
    end

    context 'without an h-card or h-entry' do
      let :webmention do
        Webmention.new source: 'http://example.com/bar'
      end

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
      let :entry do
        stub(author: stub(format: stub(url: stub(to_s: '/'))))
      end

      let :webmention do
        Webmention.new source: 'http://example.com/bar'
      end

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the author URL.' do
        expect(webmention.author_url).to eql('http://example.com/')
      end
    end

    context 'with an h-card' do
      let :card do
        stub(url: stub(to_s: '/'))
      end

      let :webmention do
        Webmention.new source: 'http://example.com/bar'
      end

      before :each do
        webmention.stubs(:entry).returns nil
        webmention.stubs(:card).returns card
      end

      it 'returns the author URL.' do
        expect(webmention.author_url).to eql('http://example.com/')
      end
    end

    context 'without an h-card or h-entry' do
      let :webmention do
        Webmention.new source: 'http://example.com/bar'
      end

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
      let :entry do
        stub(url: stub(to_s: '/foo'))
      end

      let :webmention do
        Webmention.new source: 'http://example.com/foo'
      end

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the entry URL.' do
        expect(webmention.entry_url).to eql('http://example.com/foo')
      end
    end

    context 'without an h-entry' do
      let :webmention do
        Webmention.new source: 'http://example.com/foo'
      end

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
      let :entry do
        stub(published: stub(to_s: '2000-01-01T00:00:00'))
      end

      let :webmention do
        Webmention.new
      end

      before :each do
        webmention.stubs(:entry).returns entry
      end

      it 'returns the date published.' do
        expect(webmention.published_at).to eql(Time.parse '2000-01-01T00:00:00')
      end
    end

    context 'without an h-entry' do
      let :webmention do
        Webmention.new created_at: Time.parse('2000-01-01T00:00:00')
      end

      before :each do
        webmention.stubs(:entry).returns nil
      end

      it 'returns the date created in place of the date published.' do
        expect(webmention.published_at).to eql(Time.parse '2000-01-01T00:00:00')
      end
    end
  end
end