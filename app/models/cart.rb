class Cart
  attr_reader :session

  def initialize(session)
    @session = session
    @session[:cart] ||= {
        books: Hash.new, # Hash{book_id{price, quantity}}
        total_amount: 0,
        created_at: Time.now
    }
  end

  def add_book(book_id)
    requested_book = Book.find_by_id(book_id) if book_id.present?
    if requested_book.present?
      if cart_books[book_id].nil?
        cart_books[book_id] = Hash.new
        cart_books[book_id][:quantity] = 1
      else
        cart_books[book_id][:quantity] += 1
      end
      cart_books[book_id][:total_price] = cart_books[book_id][:quantity] * requested_book.unit_price
      cart[:total_amount] += requested_book.unit_price
      return true
    else
      return false
    end
  end

  def remove_book(book_id)
    requested_book = Book.find_by_id(book_id) if book_id.present?
    if requested_book.present? && cart_books[book_id].present?
      cart[:total_amount] -= cart_books[book_id][:quantity] * requested_book.unit_price
      cart_books.delete(book_id)
    end
  end

  def update_cart(book_ids, quantities)
    book_ids.each_with_index do |book_id, index|
      update_item(book_id, quantities[index])
    end
  end

  def expired?
    cart[:created_at] < 3.hours.ago
  end

  private
    def update_item(book_id, quantity)
      if book_id.present? && quantity.present? && quantity.to_i > 0
        book = Book.find_by_id(book_id) if book_id.present?
        if book.present?
          quantity = quantity.to_i
          quantity_diff = quantity - cart_books[book_id][:quantity]
          cart_books[book_id][:quantity] = quantity
          cart_books[book_id][:total_price] = quantity * book.unit_price
          cart[:total_amount] += quantity_diff * book.unit_price
        end
      end
    end

    def cart
      @session[:cart]
    end

    def cart_books
      @session[:cart][:books]
    end
end