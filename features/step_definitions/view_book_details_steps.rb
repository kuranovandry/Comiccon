Given(/^System has a book with (\d+) comments$/) do |comment_count|
  @book = FactoryGirl.create(:book)
  FactoryGirl.create_list(:comment, comment_count.to_i, book: @book)
end

When(/^I visit the link of a book$/) do
  visit book_path(@book)
end

Then(/^I should see all details of the book$/) do
  [:title, :description, :author_name, :publisher_name, :published_date,
   :unit_price, :total_rating_count, :average_rating].each do |attribute|
    page.should have_content(@book.send(attribute))
  end
end

And(/^I should see the comment list of the book$/) do
  comments = @book.comments.order(created_at: :desc)
  page.should have_selector(".comment", count: comments.count)
  page.all(".comment").each_with_index do |selector, index|
    within selector do
      page.should have_content(comments[index].content)
      page.should have_content(comments[index].rating)
      page.should have_content(comments[index].user.full_name)
      page.should have_content(comments[index].created_at)
    end
  end
end