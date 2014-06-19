module ApplicationHelper
  def build_category_select_options
    @categories = [["All categories", nil]]
    Category.select('name, id').each do |category|
      @categories << [category.name, category.id]
    end
  end
end