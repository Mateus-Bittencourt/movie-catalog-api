require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    it 'works! 200 status code' do
      get movies_path
      expect(response).to have_http_status(200)
    end
    it 'returns a list of movies' do
      create(:movie)
      get movies_path
      expect(response.body).to include_json([
                                              id: /\d+/,
                                              title: (be_kind_of String),
                                              genre: (be_kind_of String),
                                              year: /\d+/,
                                              country: (be_kind_of String),
                                              published_at: /\d{4}-\d{2}-\d{2}/,
                                              description: (be_kind_of String)
                                            ])
    end
  end

  describe 'POST /movies' do
    it 'import CSV file' do
      headers = { 'Content-Type' => 'text/csv' }
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'netflix_titles.csv'), 'text/csv')
      post movies_path, params: { file: }, headers: headers

      expect(response).to have_http_status(201)
      expect(response.body).to include_json(message: 'Movies imported successfully')
    end
  end
end
