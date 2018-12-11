require 'rails_helper'
require_relative 'shared/archives'
require_relative 'shared/syndications'

RSpec.describe '/tags', type: :request do
  context 'GET' do
    describe '/tags' do
      it 'is successful' do
        post = create :post
        tag_name = 'tag'
        post.tag_list.add(tag_name)
        post.save
        get tags_path
        expect(response.successful?).to eq(true)
      end
    end

    describe '/tags/:id' do
      context 'logged in' do
        it 'is successful' do
          log_in
          post = create :post
          tag_name = 'tag'
          post.tag_list.add(tag_name)
          post.save
          get tag_path(tag_name)
          expect(response.successful?).to eq(true)
        end
      end

      context 'not logged in' do
        it 'is successful' do
          post = create :post
          tag_name = 'tag'
          post.tag_list.add(tag_name)
          post.save
          get tag_path(tag_name)
          expect(response.successful?).to eq(true)
        end
      end
    end
  end
end
