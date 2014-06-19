require 'spec_helper'

describe CategoriesController do
  let(:categories) { FactoryGirl.create_list(:category_with_books, 2, book_count: 2) }
  let(:category) { categories.first }
  let(:category2) { categories.last }

  describe "GET index" do
    before do
      categories
      get :index
    end

    it "populates an array of categories" do
      assigns(:categories).should eq(categories)
    end

    it "renders the index view" do
      response.should render_template("index")
    end

    it "order categories by sort_order" do
      category.sort_order.should < category2.sort_order
    end
  end

  describe "GET show" do
    before { get :show, id: category }

    it "assigns the requested category to category variable" do
      assigns(:category).should eq(category)
    end

    it "assigns the books belong to requested category to books variable" do
      assigns(:books).should =~ category.books
    end

    it "renders the show view" do
      response.should render_template :show
    end
  end
end

