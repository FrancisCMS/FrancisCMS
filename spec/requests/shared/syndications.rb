require 'rails_helper'

shared_examples_for 'syndications' do |resource_type|
  let(:resource_path) { public_send("#{resource_type}_path") }
  let(:resource_syndications_path) { public_send("#{resource_type}_syndications_path") }

  describe "/#{resource_type}/syndications" do
    it 'is successful' do
      log_in
      expect { post resource_syndications_path(resource_type, resource_id: resource.id) }
        .to change { ::FrancisCms::Syndication.count }.by(+1)
      expect(response.successful?).to eq(true)
    end
  end

  describe "/#{resource_type}/syndications/:year" do
    it 'is successful' do
      log_in
      syndication = create :syndication, syndicatable: resource
      expect { delete resource_syndication_path(resource_type, syndication, resource_id: resource.id) }
        .to change { ::FrancisCms::Syndication.count }.by(-1)
      expect(response).to redirect_to
    end
  end

  def resource_path(rsc)
    public_send("#{resource_type}_path", rsc)
  end

  def resource_syndication_path(resource_type, syndication, resource_id:)
    public_send(
      "#{resource_type.singularize}_path",
      syndication,
      "#{resource_type.singularize}_id" => resource_id
    )
  end

  def resource_syndications_path(resource_type, resource_id:)
    public_send(
      "#{resource_type.singularize}_syndications_path",
      "#{resource_type.singularize}_id".to_sym => resource_id
    )
  end
end
