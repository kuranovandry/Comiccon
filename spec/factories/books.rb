FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    description Faker::Lorem.paragraph
    author_name Faker::Name.name
    publisher_name Faker::Company.name
    published_date Date.today
    unit_price Faker::Number.number(2)
    total_rating_count 0
    total_rating_value 0

    factory :book_with_comments do
      ignore do
        comment_count 10
      end

      comments { create_list(:comment, comment_count) }
    end
  end
end