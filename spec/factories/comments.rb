FactoryGirl.define do
  factory :comment do
    rating Random.new.rand(Comment::RATING_VALUES)
    content Faker::Lorem.paragraph
    user
  end
end