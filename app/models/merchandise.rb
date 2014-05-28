class Merchandise < ActiveRecord::Base
	validates_presence_of(:name)
  validates_presence_of(:price)
  validates_presence_of(:notes)

	belongs_to :order, :inverse_of => :merchandise

  rails_admin do
    nestable_list true
    list do
      field :name
      field :price
      field :notes
    end

    edit do
        field :name
        field :price
        field :notes
      end
  end
end
