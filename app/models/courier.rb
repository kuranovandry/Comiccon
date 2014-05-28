class Courier < ActiveRecord::Base
	validates_presence_of(:name)
  validates_presence_of(:surname)
  validates_presence_of(:delivery)

  has_many :events_couriers
  has_many :events, class_name:"FullcalendarEngine::Event", through: :events_couriers


  rails_admin do
    nestable_list true
    list do
      field :name
      field :surname
      field :delivery
    end

    edit do
        field :name
        field :surname
        field :delivery
        field :events
        field :notes
      end
  end
  def delivery_enum
    ['Afoot', 'Car', 'Plane', 'Ship', 'Other']
  end
end
