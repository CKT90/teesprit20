class Variant < ActiveRecord::Base

    extend FriendlyId
    friendly_id :SKU, slug_column: :SKU, use: [:slugged,:finders]
    include SkuGenerator.new(prefix: 'V')

	
	has_many :option_value_variants, inverse_of: :variant
	has_many :option_values, through: :option_value_variants

	has_many :line_items, inverse_of: :variant
	has_many :orders, through: :line_items
	
	has_many :variant_images, inverse_of: :variant
	has_many :images, through: :variant_images

	belongs_to :product, touch: true #, :foreign_key => 'variant_id'


	with_options presence: true do
	  validates :option_values
	  validates :SKU
	  validates :price, numericality: {greater_than_or_equal_to: 0.01}
	  #validates :cost_price, numericality: {greater_than_or_equal_to: 0.01}
	  validates :count_on_hand, numericality: {only_integer: true, greater_than_or_equal_to: 0}
	end


	def should_generate_new_friendly_id?
  		SKU_changed?
	end


   	before_save :uppercase_variant_sku

  	def uppercase_variant_sku
    	self.SKU.upcase!
  	end



end
