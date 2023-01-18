require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'Validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:genre) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:published_at) }
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'Class Methods' do
    it '#search_through_all_fields' do
      create(:movie, title: 'The Shawshank Redemption')
      create(:movie, title: 'The Godfather')
      create(:movie, title: 'The Godfather: Part II')
      expect(Movie.search_through_all_fields('Godfather').count).to eq(2)
    end
  end
end
