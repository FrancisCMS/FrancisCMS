require 'rails_helper'
require_relative 'shared/archives'
require_relative 'shared/syndications'

RSpec.describe '/links', type: :request do
  # include_examples 'syndications', 'links' do
  #   let(:resource) { create :link, published_at: ::Time.current }
  # end

  context 'DELETE' do
    describe '/link/:id' do
      it 'deletes the link' do
        log_in
        link = create :link
        expect { delete link_path(link) }
          .to change { ::FrancisCms::Link.count }.by(-1)
        expect(response).to redirect_to(links_path)
      end
    end
  end

  context 'GET' do
    include_examples 'archives', 'links' do
      let(:resource) { create :link, published_at: ::Time.current }
    end

    describe '/links' do
      it 'is successful' do
        link = create :link
        get links_path
        expect(response.successful?).to eq(true)
        expect(response.body).to include(link.title)
      end
    end

    describe '/links/:id' do
      it 'is successful' do
        link = create :link, published_at: ::Time.current
        get link_path(link)
        expect(response.successful?).to eq(true)
      end
    end

    describe '/links/:id/edit' do
      it 'is successful' do
        log_in
        link = create :link, published_at: ::Time.current
        get edit_link_path(link)
        expect(response.successful?).to eq(true)
      end
    end

    describe '/links/new' do
      it 'is successful' do
        log_in
        get new_link_path
        expect(response.successful?).to eq(true)
      end
    end
  end

  context 'PATCH' do
    describe '/link/:id' do
      it 'updates the link' do
        log_in
        link = create :link
        new_body = ::Faker::Markdown.random
        params = { link: link.attributes.merge(body: new_body) }
        expect { patch link_path(link), params }
          .to change { link.reload.body }.to(new_body)
        expect(response).to redirect_to(link_path(link))
      end

      it 'renders :edit when link update fails' do
        log_in
        link = create :link
        params = { link: { url: nil } }
        patch link_path(link), params
        expect(response).to render_template(:edit)
      end
    end
  end

  context 'POST' do
    describe '/links' do
      it 'creates a link' do
        log_in
        params = { link: attributes_for(:link) }
        expect { post links_path, params }
          .to change { ::FrancisCms::Link.count }.by(+1)
        expect(response).to redirect_to(link_path(::FrancisCms::Link.last))
      end

      it 'renders :new if link creation fails' do
        log_in
        params = { link: attributes_for(:link).merge(url: nil) }
        expect { post links_path, params }
          .to change { ::FrancisCms::Link.count }.by(0)
        expect(response).to render_template(:new)
      end
    end
  end
end
