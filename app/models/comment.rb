class Comment < ActiveRecord::Base
  after_create { update_book }

  RATING_VALUES = 1..5

  belongs_to :user
  belongs_to :book

  validates :content, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: RATING_VALUES.first,
                                     less_than_or_equal_to: RATING_VALUES.last}

  private

    def update_book
      book.update_attributes({total_rating_count: book.total_rating_count + 1,
                              total_rating_value: book.total_rating_value + self.rating})
    end
end