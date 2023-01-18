class Movie < ApplicationRecord
  validates :title, :genre, :year, :published_at, :description, presence: true
  validates :title, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_through_all_fields,
                  against: %i[title genre year country published_at description],
                  using: {
                    tsearch: { prefix: true }
                  }
end
