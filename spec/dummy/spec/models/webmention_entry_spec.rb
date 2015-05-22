require 'rails_helper'

module FrancisCms
  describe WebmentionEntry do
    let :source_page_markup do
      ERB.new(File.read('./spec/fixtures/source_page.html.erb')).result(binding)
    end

    let(:collection) { Microformats2.parse(source_page_markup) }
    let(:webmention) { Webmention.new source: 'http://example.com/foo/bar' }

    context 'creates a webmention entry' do
      before :each do
        WebmentionEntry.stubs(:create)
        WebmentionEntry.stubs(:attributes_from_collection).returns({ foo: 'bar' })

        WebmentionEntry.create_from_collection(webmention, collection)
      end

      it 'with attributes from a collection.' do
        expect(WebmentionEntry).to have_received(:create).with({ foo: 'bar' })
      end
    end

    it 'returns attributes from a collection.' do
      attributes = {
        author_name: 'Foo Bar',
        author_photo_url: 'http://www.placecage.com/150/150',
        author_url: 'http://example.com/',
        entry_content: '<p>Sample source post body.</p>',
        entry_name: 'Sample source page title',
        entry_url: 'http://example.com/foo/bar',
        published_at: Time.parse('2014-09-21T19:23:11Z'),
        webmention: webmention
      }

      expect(WebmentionEntry.attributes_from_collection(webmention, collection)).to eq(attributes)
    end

    context 'builds attributes' do
      let(:webmention_entry) { WebmentionEntry::AttributesBuilder.new(webmention, nil)}

      context '#author_name' do
        context 'with an h-entry' do
          let(:entry) { stub(author: stub(format: stub(name: stub(to_s: 'Foo Bar')))) }

          before :each do
            webmention_entry.stubs(:entry).returns entry
          end

          it 'returns the author name.' do
            expect(webmention_entry.author_name).to eql('Foo Bar')
          end
        end

        context 'with an h-card' do
          let(:card) { stub(name: stub(to_s: 'Foo Bar')) }

          before :each do
            webmention_entry.stubs(:entry).returns nil
            webmention_entry.stubs(:card).returns card
          end

          it 'returns the author name.' do
            expect(webmention_entry.author_name).to eql('Foo Bar')
          end
        end

        context 'without an h-card or h-entry' do
          let(:webmention) { Webmention.new source: 'http://example.com/foo/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns nil
            webmention_entry.stubs(:card).returns nil
          end

          it 'returns the source URLs domain in place of the author name.' do
            expect(webmention_entry.author_name).to eql('example.com')
          end
        end
      end

      context '#author_photo_url' do
        context 'with an h-entry' do
          let(:entry) { stub(author: stub(format: stub(photo: stub(to_s: '/foo.png')))) }
          let(:webmention) { Webmention.new source: 'http://example.com/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns entry
          end

          it 'returns the author photo.' do
            expect(webmention_entry.author_photo_url).to eql('http://example.com/foo.png')
          end
        end

        context 'with an h-card' do
          let(:card) { stub(photo: stub(to_s: '/foo.png')) }
          let(:webmention) { Webmention.new source: 'http://example.com/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns nil
            webmention_entry.stubs(:card).returns card
          end

          it 'returns the author photo.' do
            expect(webmention_entry.author_photo_url).to eql('http://example.com/foo.png')
          end
        end

        context 'without an h-card or h-entry' do
          let(:webmention) { Webmention.new source: 'http://example.com/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns nil
            webmention_entry.stubs(:card).returns nil
          end

          it 'returns nil in place of the author photo.' do
            expect(webmention_entry.author_photo_url).to eql(nil)
          end
        end
      end

      context '#author_url' do
        context 'with an h-entry' do
          let(:entry) { stub(author: stub(format: stub(url: stub(to_s: '/')))) }
          let(:webmention) { Webmention.new source: 'http://example.com/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns entry
          end

          it 'returns the author URL.' do
            expect(webmention_entry.author_url).to eql('http://example.com/')
          end
        end

        context 'with an h-card' do
          let(:card) { stub(url: stub(to_s: '/')) }
          let(:webmention) { Webmention.new source: 'http://example.com/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns nil
            webmention_entry.stubs(:card).returns card
          end

          it 'returns the author URL.' do
            expect(webmention_entry.author_url).to eql('http://example.com/')
          end
        end

        context 'without an h-card or h-entry' do
          let(:webmention) { Webmention.new source: 'http://example.com/bar' }

          before :each do
            webmention_entry.stubs(:entry).returns nil
            webmention_entry.stubs(:card).returns nil
          end

          it 'returns the source URL host and domain as the author URL.' do
            expect(webmention_entry.author_url).to eql('http://example.com/')
          end
        end
      end

      context '#entry_url' do
        context 'with an h-entry' do
          let(:entry) { stub(url: stub(to_s: '/foo')) }
          let(:webmention) { Webmention.new source: 'http://example.com/foo' }

          before :each do
            webmention_entry.stubs(:entry).returns entry
          end

          it 'returns the entry URL.' do
            expect(webmention_entry.entry_url).to eql('http://example.com/foo')
          end
        end

        context 'without an h-entry' do
          let(:webmention) { Webmention.new source: 'http://example.com/foo' }

          before :each do
            webmention_entry.stubs(:entry).returns nil
          end

          it 'returns the source URL in place of the entry URL.' do
            expect(webmention_entry.entry_url).to eql('http://example.com/foo')
          end
        end
      end

      context '#published_at' do
        context 'with an h-entry' do
          let(:entry) { stub(published: stub(to_s: '2000-01-01T00:00:00')) }

          before :each do
            webmention_entry.stubs(:entry).returns entry
          end

          it 'returns the date published.' do
            expect(webmention_entry.published_at).to eql(Time.parse '2000-01-01T00:00:00')
          end
        end

        context 'without an h-entry' do
          let(:webmention) { Webmention.new created_at: Time.parse('2000-01-01T00:00:00') }

          before :each do
            webmention_entry.stubs(:entry).returns nil
          end

          it 'returns the date created in place of the date published.' do
            expect(webmention_entry.published_at).to eql(Time.parse '2000-01-01T00:00:00')
          end
        end
      end
    end
  end
end
