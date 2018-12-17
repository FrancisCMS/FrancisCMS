require 'rails_helper'
require 'models/shared/taggable'

module FrancisCms
  RSpec.describe Post, type: :model do
    include_examples 'taggable' do
      let(:model) { create :post }
    end
  end
end
