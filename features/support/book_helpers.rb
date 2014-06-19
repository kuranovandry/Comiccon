def comment_rate(content, rating)
  visit book_path(@book)
  fill_in "comment_content", with: content
  select rating.to_i, from: "comment_rating"
  click_button "Post"
end

def update_books(category, book_count, field, value)
  if category.books.count >= book_count
    i = 0
    while i < book_count do
      category.books[i].update_attribute(field, value)
      i += 1
    end
  end
end

def add_books_to_cart(books)
  books.each do |book|
    visit book_path(book)
    find("#add-to-cart-btn").click
  end
end