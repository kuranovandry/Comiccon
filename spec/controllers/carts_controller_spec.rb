require 'spec_helper'

describe CartsController do
  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:confirmed_user) }

  before { Cart.new(session) }

  describe "GET index" do
    before { get :index }

    it "renders the index view" do
      response.should render_template :index
    end

    it "assigns the session cart books to cart_items variable" do
      assigns(:cart_items).should eq session[:cart][:books]
    end
  end

  describe "add book to cart" do
    describe "when user is not signed in and cart is just created" do
      before { post :add_book, book_id: book.id }

      it "shows a succesful message" do
        flash[:success].should == "Book added succesfully to cart"
      end

      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is signed in and cart is created more than 3 hours ago" do
      before do
        sign_in user
        session[:cart][:create_at] = 4.hours.ago
        post :add_book, book_id: book.id
      end

      it "shows a succesful message" do
        flash[:success].should == "Book added succesfully to cart"
      end

      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is not signed in and cart is created more than 3 hours ago" do
      before do
        session[:cart][:created_at] = 4.hours.ago
        post :add_book, book_id: book.id
      end

      it "resets cart to empty" do
        session[:cart][:books].should be_empty
      end

      it "shows an alert message" do
        flash[:alert].should == "Your shopping cart has expired!"
      end

      it "redirects to the root path" do
        response.should redirect_to root_path
      end
    end
  end

  describe "edit quantity" do
    before { post :add_book, book_id: book.id }

    describe "when user is not signed in and cart is just created" do
      before { put :update_cart, book_ids: [book.id], quantities: [10] }
      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is signed in and cart is created more than 3 hours ago" do
      before do
        sign_in user
        session[:cart][:create_at] = 4.hours.ago
        put :update_cart, book_ids: [book.id], quantities: [10]
      end

      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is not signed in and cart is created more than 3 hours ago" do
      before do
        session[:cart][:created_at] = 4.hours.ago
        put :update_cart, book_ids: [book.id], quantities: [10]
      end

      it "resets cart to empty" do
        session[:cart][:books].should be_empty
      end

      it "redirects to the root path" do
        response.should redirect_to root_path
      end
    end
  end

  describe "remove book from cart" do
    before { post :add_book, book_id: book.id }

    describe "when user is not signed in and cart is just created" do
      before { delete :remove_book, book_id: book.id }
      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is signed in and cart is created more than 3 hours ago" do
      before do
        sign_in user
        session[:cart][:create_at] = 4.hours.ago
        delete :remove_book, book_id: book.id
      end

      it "redirects to the cart path" do
        response.should redirect_to carts_path
      end
    end

    describe "when user is not signed in and cart is created more than 3 hours ago" do
      before do
        session[:cart][:created_at] = 4.hours.ago
        delete :remove_book, book_id: book.id
      end

      it "resets cart to empty" do
        session[:cart][:books].should be_empty
      end

      it "redirects to the root path" do
        response.should redirect_to root_path
      end
    end
  end
end