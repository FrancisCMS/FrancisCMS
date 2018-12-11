require 'rails_helper'
require_relative 'shared/archives'
require_relative 'shared/syndications'

RSpec.describe '/photos', type: :request do
  # include_examples 'syndications', 'photos' do
  #   let(:resource) { create :photo, published_at: ::Time.current }
  # end

  context 'DELETE' do
    describe '/photo/:id' do
      it 'deletes the photo' do
        log_in
        photo = create :photo
        expect { delete photo_path(photo) }
          .to change { ::FrancisCms::Photo.count }.by(-1)
        expect(response).to redirect_to(photos_path)
      end
    end
  end

  context 'GET' do
    include_examples 'archives', 'photos' do
      let(:resource) { create :photo, published_at: ::Time.current }
    end

    describe '/photos' do
      it 'is successful' do
        photo = create :photo, body: ::SecureRandom.hex
        get photos_path
        expect(response.successful?).to eq(true)
        expect(response.body).to include(photo.body)
      end
    end

    describe '/photos/:id' do
      it 'is successful' do
        photo = create :photo, published_at: ::Time.current
        get photo_path(photo)
        expect(response.successful?).to eq(true)
      end
    end

    describe '/photos/:id/edit' do
      it 'is successful' do
        log_in
        photo = create :photo, published_at: ::Time.current
        get edit_photo_path(photo)
        expect(response.successful?).to eq(true)
      end
    end

    describe '/photos/new' do
      it 'is successful' do
        log_in
        get new_photo_path
        expect(response.successful?).to eq(true)
      end
    end
  end

  context 'PATCH' do
    describe '/photo/:id' do
      it 'updates the photo' do
        log_in
        photo = create :photo
        new_body = ::Faker::Markdown.random
        params = { photo: photo.attributes.merge(body: new_body) }
        expect { patch photo_path(photo), params }
          .to change { photo.reload.body }.to(new_body)
        expect(response).to redirect_to(photo_path(photo))
      end
    end
  end

  context 'POST' do
    describe '/photos' do
      it 'creates a photo' do
        log_in
        file = fixture_file_upload('photo.jpg')
        params = { photo: { photo: file } }
        expect { post photos_path, params }
          .to change { ::FrancisCms::Photo.count }.by(+1)
        expect(response).to redirect_to(photo_path(::FrancisCms::Photo.last))
      end

      it 'renders :new when photo creation fails' do
        log_in
        expect { post photos_path, photo: {} }
          .to change { ::FrancisCms::Photo.count }.by(0)
        expect(response).to render_template(:new)
      end
    end
  end
end
