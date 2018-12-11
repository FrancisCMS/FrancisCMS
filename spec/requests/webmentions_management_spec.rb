require 'rails_helper'
require_relative 'shared/syndications'

RSpec.describe '/webmentions', type: :request do
  context 'DELETE' do
    describe '/webmention/:id' do
      it 'deletes the webmention' do
        log_in
        webmention = create :webmention
        expect { delete webmention_path(webmention) }
          .to change { ::FrancisCms::Webmention.count }.by(-1)
        expect(response).to redirect_to(webmentions_path)
      end
    end
  end

  context 'GET' do
    describe '/webmentions' do
      it 'is successful' do
        create :webmention
        get webmentions_path
        expect(response.successful?).to eq(true)
      end
    end

    describe '/webmentions/:id' do
      it 'is successful' do
        webmention = create :webmention
        get webmention_path(webmention)
        expect(response.successful?).to eq(true)
      end
    end
  end

  context 'PATCH' do
    describe '/webmention/:id' do
      it 'updates the webmention' do
        log_in
        webmention = create :webmention, verified_at: ::Time.current
        allow_any_instance_of(::FrancisCms::Webmention)
          .to receive(:verify)
          .and_return(true)
        allow_any_instance_of(::FrancisCms::Webmention)
          .to receive(:verified_at)
          .and_return(::Time.current)
        new_source = ::Faker::Internet.url
        params = { webmention: webmention.attributes.merge(source: new_source) }
        expect { patch webmention_path(webmention), params }
          .to change { webmention.reload.source }.to(new_source)
        expect(response).to redirect_to(webmention_path(webmention))
      end

      it 'fails gracefully when failing to update a webmention' do
        skip 'crashing'
        webmention = create :webmention, verified_at: ::Time.current
        expect do
          patch webmention_path(webmention), target: nil, source: nil
        end.to change { ::FrancisCms::Webmention.count }.by(0)
        expect(response.status).to eq(422)
      end
    end
  end

  context 'POST' do
    describe '/webmentions' do
      it 'creates a webmention' do
        params = attributes_for(:webmention)
        expect { post webmentions_path, params }
          .to change { ::FrancisCms::Webmention.count }.by(+1)
        expect(response.successful?).to eq(true)
      end

      it 'fails gracefully when failing to create a webmention' do
        expect { post webmentions_path, target: nil, source: nil }
          .to change { ::FrancisCms::Webmention.count }.by(0)
        expect(response.status).to eq(400)
      end
    end
  end
end
