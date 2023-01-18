class Movie < ApplicationRecord
  validates :title, :genre, :year, :published_at, :description, presence: true
  validates :title, uniqueness: true
end
