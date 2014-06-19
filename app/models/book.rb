class Book < ActiveRecord::Base
  validates :title, presence: true
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_rating_count, presence: true, numericality: { only_integer:true, greater_than_or_equal_to: 0 }
  validates :total_rating_value, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :categories

  scope :title_or_author_match, ->(keyword) { where("lower(title) like '%#{keyword.downcase}%' or
                                                     lower(author_name) like '%#{keyword.downcase}%'") }
  scope :of_category, ->(category_id) { joins(:categories).where("categories.id='#{category_id}'") }

  has_attached_file :photo, :styles => { :medium => "200x300>", :thumb => "140x210>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  self.per_page = 12

  def average_rating
    total_rating_count <= 0 ? 0 : (total_rating_value.to_f / total_rating_count).round(2)
  end

  def self.search keyword, category_id, page, per_page
    results = Book.title_or_author_match(keyword)
    results = results.of_category(category_id) if category_id.present?
    results.paginate(page: page, per_page: per_page)
  end
end