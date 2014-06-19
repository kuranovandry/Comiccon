require 'spec_helper'

describe CommentsController do
  describe "POST create" do
    let(:book) { FactoryGirl.create(:book) }
    let(:user) { FactoryGirl.create(:confirmed_user) }
    let(:comment) { FactoryGirl.build(:comment, book: book) }

    before { sign_in user }

    describe "with valid attributes" do
      it "creates a new comment" do
        expect {
          post(:create, book_id: book.id, comment: comment.attributes)
        }.to change(Comment, :count).by(1)
      end

      describe "after creating new comment" do
        before { post(:create, book_id: book.id, comment: comment.attributes) }

        it "redirects to the book path" do
           response.should redirect_to book_path(book)
        end

        it "shows a success message" do
          flash[:success].should == "Comment posted!"
        end
      end
    end

    describe "with invalid attributes" do
      before { comment.content = "" }

      it "does not create a new comment" do
        expect { post(:create, book_id: book.id, comment: comment.attributes) }.not_to change(Comment, :count)
      end

      describe "after faiing" do
        before { post(:create, book_id: book.id, comment: comment.attributes) }

        it "redirects to the book path" do
          response.should redirect_to book_path(book)
        end

        it "shows an error message" do
          flash[:error].should == "Error occured while posting comment, please try again!"
        end
      end
    end
  end
end