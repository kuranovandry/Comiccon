class Order < ActiveRecord::Base
	validates_presence_of(:name_surname)
  validates_presence_of(:country)
  validates_presence_of(:street)
  validates_presence_of(:payment_method)

	has_many :merchandise

  rails_admin do
    nestable_list true
    list do
      field :name_surname
      field :country
      field :street
      field :total_price
    end

    edit do
        field :name_surname
        field :country
        field :merchandise
        field :street
        field :delivery
        field :notes
      end
  end

  def payment_method_enum
  	['Card', 'Web-pey', 'On delivery']
  end	
  def delivery_enum
    ['Afoot', 'Car', 'Plane', 'Ship', 'Other']
  end
end
