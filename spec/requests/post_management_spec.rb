require 'rails_helper'
require_relative 'shared/archives'
require_relative 'shared/syndications'

RSpec.describe '/posts', type: :request do
  # include_examples 'syndications', 'posts' do
  #   let(:resource) { create :post, published_at: ::Time.current }
  # end

  context 'DELETE' do
    describe '/post/:id' do
      it 'deletes the post' do
        log_in
        post = create :post
        expect { delete post_path(post) }
          .to change { ::FrancisCms::Post.count }.by(-1)
        expect(response).to redirect_to(posts_path)
      end
    end
  end

  context 'GET' do
    include_examples 'archives', 'posts' do
      let(:resource) { create :post, published_at: ::Time.current }
    end

    describe '/posts/' do
      it 'is successful' do
        create :post, published_at: ::Time.current
        get posts_path
        expect(response.successful?).to eq(true)
      end
    end

    describe '/posts/:id' do
      it 'is successful' do
        post = create :post, published_at: ::Time.current
        get post_path(post)
        expect(response.successful?).to eq(true)
      end
    end

    describe '/posts/:id/edit' do
      it 'is successful' do
        log_in
        post = create :post, published_at: ::Time.current
        get edit_post_path(post)
        expect(response.successful?).to eq(true)
      end
    end

    describe '/posts/new' do
      it 'is successful' do
        log_in
        get new_post_path
        expect(response.successful?).to eq(true)
      end
    end
  end

  context 'PATCH' do
    describe '/post/:id' do
      it 'updates the post' do
        log_in
        post = create :post
        new_body = ::Faker::Markdown.random
        params = { post: post.attributes.merge(body: new_body) }
        expect { patch post_path(post), params }
          .to change { post.reload.body }.to(new_body)
        expect(response).to redirect_to(post_path(post))
      end

      it 'renders :edit when post update fails' do
        log_in
        post = create :post
        params = { post: { body: nil } }
        patch post_path(post), params
        expect(response).to render_template(:edit)
      end
    end
  end

  context 'POST' do
    describe '/posts' do
      it 'creates a post' do
        log_in
        params = { post: attributes_for(:post) }
        expect { post posts_path, params }
          .to change { ::FrancisCms::Post.count }.by(+1)
        expect(response).to redirect_to(post_path(::FrancisCms::Post.last))
      end

      it 'renders :new when post creation fails' do
        log_in
        params = { post: attributes_for(:post).merge(body: nil) }
        expect { post posts_path, params }
          .to change { ::FrancisCms::Post.count }.by(0)
        expect(response).to render_template(:new)
      end
    end
  end
end
