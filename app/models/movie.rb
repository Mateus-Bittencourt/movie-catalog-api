class Movie < ApplicationRecord
  validates :title, :genre, :year, :country, :published_at, :description, presence: true
end
