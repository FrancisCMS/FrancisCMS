require 'rails_helper'

shared_examples_for 'archives' do |resource_type|
  describe 'GET' do
    describe "/#{resource_type}/archives" do
      it 'is successful' do
        get "/#{resource_type}/archives"
        expect(response.successful?).to eq(true)
      end
    end

    describe "/#{resource_type}/archives/:year" do
      it 'is successful' do
        get "/#{resource_type}/archives/#{resource.published_at.to_date.year}"
        expect(response.successful?).to eq(true)
      end
    end
  end
end
