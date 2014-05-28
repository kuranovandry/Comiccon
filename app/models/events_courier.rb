class EventsCourier < ActiveRecord::Base
	belongs_to :courier
	belongs_to :event, class_name:"FullcalendarEngine::Event"

	rails_admin do
		visible false
	end
end
