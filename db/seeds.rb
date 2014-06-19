# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#require 'faker'

def create_admin
  User.create(email: "admin@comiccon.com", full_name: "admin",
              password: "password", password_confirmation: "password",
              birthday: "1988/07/22", phone: "+84 123456789",
              confirmed_at: Date.today, admin: true)
end

def create_users(count)
  count.times.each do |index|
    User.create(full_name: Faker::Name.name, email: "user#{index}@example.com",
                password: "password", password_confirmation: "password",
                birthday: rand(50.years).ago, phone: "+84 #{Faker::Number.number(9)}",
                confirmed_at: rand(2.years).ago, admin: false)
  end
end

def create_categories
  names = ["Marvel", "DC Comics", "Star Wars", "Alterna",
            "Another"]
  names.each_with_index do |name, index|
    Category.create(name: name, sort_order: (index + 1)*10)
  end
end

# def create_books(count_range)
#   image_files = Dir.glob("public/system/books/photos/book_covers/*")
#   Category.all.each do |category|
#     book_count = rand(eval(count_range.to_s)).to_i
#     book_count.times do
#       category.books.create(title: Faker::Company.catch_phrase,
#                             description: Faker::Lorem.paragraph(15),
#                             author_name: Faker::Name.name,
#                             publisher_name: Faker::Company.name,
#                             published_date: rand(10.years).ago,
#                             photo: File.open(File.join(Rails.root, image_files.sample)),
#                             unit_price: rand(1..100))
#     end
#   end
# end

def create_orders(count)
  users = User.where(admin: false)
  i = 0
  while i < count.to_i && users.count > 0 do
    Order.create(user: users[i % users.count], total_amount: 0,
                 shipping_address: Faker::Address.street_address)
    i += 1
  end
end

def create_order_lines(count_range)
  books = Book.all
  orders = Order.all
  orders.each do |order|
    order_line_count = rand(eval(count_range.to_s))
    order_line_count = (order_line_count < books.count) ? order_line_count : books.count
    i = 0
    while i < order_line_count do
      order_line = order.order_lines.create(book: books[i], unit_price: books[i].unit_price, quantity: rand(5))
      order.update_attribute(:total_amount, order.total_amount + order_line.unit_price * order_line.quantity)
      i += 1
    end
  end
end

# def create_rate_and_comment(count_range)
#   users = User.where(admin: false)
#   Book.all.each do |book|
#     comment_count = rand(eval(count_range.to_s))
#     comment_count = (comment_count < users.count) ? comment_count : users.count
#     i = 0
#     while i < comment_count do
#       book.comments.create(user: users[i], rating: rand(1..5), content: Faker::Lorem.paragraph)
#       i += 1
#     end
#   end
# end

create_categories
create_admin
create_users(ENV['user_count'].present? ? ENV['user_count'] : 5)
# create_books(ENV['book_count_range'].present? ? ENV['book_count_range'] : 4..8)
create_orders(ENV['order_count'].present? ? ENV['order_count'] : 5)
create_order_lines(ENV['order_line_count_range'].present? ? ENV['order_line_count_range'] : 2..4)
# create_rate_and_comment(ENV['comment_count_range'].present? ? ENV['comment_count_range'] : 2..4)