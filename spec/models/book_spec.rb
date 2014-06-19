require 'spec_helper'

describe Book do
  let(:book) { FactoryGirl.build(:book) }
  subject { book }

  it { should be_valid }

  [:title, :description, :author_name, :publisher_name, :published_date, :unit_price, :photo,
   :total_rating_count, :total_rating_value, :categories, :average_rating, :comments].each do |field|
    it { should respond_to(field) }
  end

  [:title, :unit_price].each do |field|
    it { should validate_presence_of(field) }
  end

  [:unit_price, :total_rating_count, :total_rating_value].each do |field|
    it { should validate_numericality_of(field).is_greater_than_or_equal_to(0) }
  end

  it { should validate_numericality_of(:total_rating_count).only_integer }
  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:comments) }

  it { should have_attached_file(:photo) }
  it { should validate_attachment_content_type(:photo).allowing('image/*').rejecting('text/*') }

  describe "average rating" do
    describe "when book has positive rate count" do
      before do
        book.total_rating_value = 10
        book.total_rating_count = 2
      end

      it "should has the right value for average rating" do
        book.average_rating.should == (book.total_rating_value / book.total_rating_count).round(2)
      end
    end

    describe "when book has no rate" do
      before do
        book.total_rating_count = 0
      end

      it "should has zero average rating" do
        book.average_rating.should == 0
      end
    end
  end

  describe "search book function" do
    let(:category) { FactoryGirl.create(:category) }
    let(:wrong_keyword) { "wrong keyword" }

    before do
      book.categories << category
      book.save
    end

    it "searches by title without category" do
      Book.search(book.title, nil, nil, nil).should == [book]
    end

    it "searches by author without category" do
      Book.search(book.author_name, nil, nil, nil).should == [book]
    end

    it "searches by title with category" do
      Book.search(book.title, category.id, nil, nil).should == [book]
    end

    it "searches by author with category" do
      Book.search(book.author_name, category.id, nil, nil).should == [book]
    end

    it "returns no result with non-exist keyword" do
      Book.search(wrong_keyword, nil, nil, nil).should be_empty
    end
  end
end
