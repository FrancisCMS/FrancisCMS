require 'rails_helper'

shared_examples_for 'taggable' do
  describe '#sorted_tags' do
    it 'returns tags sorted by name' do
      model.tag_list.add('A', 'B')
      model.save!
      tagB, tagA = model.tags
      expect(model.sorted_tags).to eq([tagA, tagB])
    end
  end
end
