require 'spec_helper'

describe Comment do
  let(:book) { FactoryGirl.create(:book) }
  let(:comment) { FactoryGirl.build(:comment, book: book) }
  subject { comment }

  it { should be_valid }

  [:rating, :content, :book, :user].each do |field|
    it { should respond_to(field) }
  end

  it { should validate_presence_of(:content) }
  it { should belong_to(:book) }
  it { should belong_to(:user) }

  describe "when rating is less than 1" do
    before { comment.rating = 0 }
    it { should be_invalid }
  end

  describe "when rating is greater than 5" do
    before { comment.rating = 6 }
    it { should be_invalid }
  end

  describe "after create" do
    it "should imcrement total rating count of book by 1" do
      expect{ comment.save }.to change(book, :total_rating_count).by(1)
    end

    it "should add new rate to total rating value of book" do
      expect{ comment.save }.to change(book, :total_rating_value).by(comment.rating)
    end
  end
end