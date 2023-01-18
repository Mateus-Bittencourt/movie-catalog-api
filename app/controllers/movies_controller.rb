require 'csv'

class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @movies = Movie.all.order(year: :desc)
  end

  def create
    csv_file = params[:file]
    return render json: { error: 'no file provided' }, status: :bad_request if csv_file.nil?
    if csv_file.content_type != 'text/csv'
      return render json: { error: 'file provided is not a csv' }, status: :unsupported_media_type
    end

    CSV.foreach(csv_file.path, headers: :first_row, header_converters: :symbol) do |row|
      movie = Movie.new(title: row[:title], genre: row[:type], year: row[:release_year].to_i, country: row[:country],
                        published_at: row[:date_added], description: row[:description].strip)
      if movie.valid?
        movie.save
      else
        return render json: { error: movie.errors.full_messages }, status: :unprocessable_entity
      end
    end
    render json: { message: 'Movies imported successfully' }, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
