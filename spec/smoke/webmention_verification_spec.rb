require 'smoke_helper'

describe 'Webmention verification' do
  let :target_post do
    Post.create title: 'Sample target post title', body: 'Sample target post body.'
  end

  let :source_post do
    Post.create title: 'Sample source post title', body: body
  end

  let :webmention do
    Webmention.create! source: post_url(source_post), target: post_url(target_post)
  end

  after :each do
    DatabaseCleaner.clean
  end

  context 'with a link to target URL in the body' do
    let :body do
      %Q{Sample source post body that [links to sample post](#{post_url(target_post)}).}
    end

    before :each do
      webmention.verify
    end

    it 'validates that source URL links to target URL.' do
      expect(webmention.verified_at).not_to eql(nil)
    end
  end

  context 'without a link to target URL in the body' do
    let :body do
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