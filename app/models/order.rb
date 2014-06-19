class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_lines, dependent: :destroy

  validates :shipping_address, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def create_order(session)
    @cart = session[:cart]
    begin
      create_order_lines
      self.total_amount = @cart[:total_amount]
      save
    rescue
      raise
    end
  end

  private
    def create_order_lines
      cart_books.keys.each do |book_id|
        book = Book.find_by_id(book_id)
        if book.present?
          self.order_lines.new(book: book,
                               unit_price: book.unit_price,
                               quantity: cart_books[book_id][:quantity])
        else
          raise "Book not found!"
        end
      end
    end

    def cart_books
      @cart[:books]
    end
end