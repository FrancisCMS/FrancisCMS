require 'smoke_helper'

describe 'Webmention verification' do
  let :target_post do
    Post.create title: 'Sample target post title', body: 'Sample target post body.'
  end

  let :source_post do
    Post.create title: 'Sample source post title', body: source_post_body
  end

  let :webmention do
    Webmention.create! source: post_url(source_post), target: post_url(target_post)
  end

  after :each do
    DatabaseCleaner.clean
  end

  context 'with a link to target URL in the source post body' do
    let :source_post_body do
      ERB.new(File.read(Rails.root + 'spec/fixtures/source_page_with_link_to_target_page.html.erb')).result(binding)
    end

    before :each do
      webmention.verify
    end

    it 'validates that source URL links to target URL.' do
      expect(webmention.verified_at).not_to eql(nil)
    end
  end

  context 'without a link to target URL in the source post body' do
    let :source_post_body do
      'Sample source post body.'
    end

    it 'deletes webmention when source URL does not link to target URL.' do
      webmention.verify

      expect { webmention.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'deletes webmention when source URL does not exist.' do
      source_post.delete

      webmention.verify

      expect { webmention.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end