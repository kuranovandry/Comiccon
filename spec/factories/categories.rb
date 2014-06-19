FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:sort_order) { |n| n }

    factory :category_with_books do
      ignore do
        book_count 10
      end
      books { create_list(:book, book_count) }
    end
  end
end