require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /movies' do
    it 'works! 200 status code' do
      get movies_path
      expect(response).to have_http_status(200)
    end
    it 'returns a list of movies' do
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
    it 'creates a movie' do
      headers = { 'ACCEPT' => 'application/json' }
      post movies_path, params: { movies: Rails.root.join('spec', 'netflix_titles.csv') }, headers: headers

      expect(response).to have_http_status(201)
    end
  end
end
