require 'spec_helper'

describe BooksController do
  let(:book) { FactoryGirl.create(:book) }
  let(:comments) { FactoryGirl.create_list(:comment, 2, book: book) }

  describe "GET show" do
    before { get :show, id: book }

    it "renders the show view" do
      response.should render_template :show
    end

    it "assigns the requested book to book variable" do
      assigns(:book).should eq(book)
    end

    it "assigns the comments belong to requested book to comments variable" do
      assigns(:comments).should =~ comments
    end
  end

  describe "GET index" do
    let(:category) { FactoryGirl.create(:category) }
    let(:categories) { [["All categories", nil], [category.name, category.id]] }

    before do
      categories
      get :index
    end

    it "renders the index view" do
      response.should render_template :index
    end

    it "populates an array of categories" do
      assigns(:books).should eq([book])
    end

    it "creates the options for category select" do
      assigns(:categories).should == categories
    end
  end

  describe "GET search" do
    before { get :search, query: book.title }

    it "renders the search view" do
      response.should render_template :search
    end

    it "assigns the search result to books variable" do
      assigns(:books).should eq([book])
    end
  end
end