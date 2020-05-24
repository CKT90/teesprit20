class Property < ActiveRecord::Base

	belongs_to :product
	with_options presence: true do
      validates :name, :uniqueness => {:scope => :value, :message => "the combination already exist", allow_blank: true }
      validates :value
    end

end
