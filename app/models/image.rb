class Image < ActiveRecord::Base

	belongs_to :product, touch: true
	has_many :variants, through: :variant_images
	has_many :variant_images

	mount_uploader :image, ImageUploader
	acts_as_list scope: :product


	with_options presence: true do
  		validates :image
	end
	
end