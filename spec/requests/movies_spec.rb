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

  describe 'GET /movies/:filter' do
    before do
      create(:movie, title: 'The Shawshank Redemption')
      create(:movie, title: 'The Godfather')
      create(:movie, title: 'The Godfather: Part II')
      create(:movie, title: 'The Dark Knight')
      create(:movie, title: '12 Angry')
      get '/movies/Godfather'
    end

    it 'works! 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns a list of movies filtered by param' do
      expect(response.body).to include_json([

                                              id: /\d+/,
                                              title: /\The Godfather/,
                                              genre: (be_kind_of String),
                                              year: /\d+/,
                                              country: (be_kind_of String),
                                              published_at: /\d{4}-\d{2}-\d{2}/,
                                              description: (be_kind_of String)
                                            ])
    end
  end

  describe 'POST /movies' do
    it 'return correct error message if no file was attached' do
      post movies_path
      expect(response.body).to include_json(error: 'no file provided')
    end

    it 'return correct error message if attached file was not a csv' do
      headers = { 'Content-Type' => 'text/csv' }
      json_file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support_files', 'json_file.json'))
      post movies_path, params: { file: json_file }, headers: headers
      expect(response.body).to include_json(error: 'file provided is not a csv')
    end

    before do
      headers = { 'Content-Type' => 'text/csv' }
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support_files', 'netflix_titles.csv'), 'text/csv')
      post movies_path, params: { file: }, headers:
    end

    it 'works! 201 status code' do
      expect(response).to have_http_status(201)
    end

    it 'import CSV file' do
      expect(response.body).to include_json(message: 'Movies imported successfully')
    end
  end
end
