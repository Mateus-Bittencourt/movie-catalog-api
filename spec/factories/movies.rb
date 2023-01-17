FactoryBot.define do
  factory :movie do
    title { '13 Reasons Why' }
    genre { 'TV Show' }
    year { 2020 }
    country { 'United States' }
    published_at { '2020-05-07' }
    description { 'A classmate receives a series of tapes that unravel the mystery of her tragic choice.' }
  end
end
