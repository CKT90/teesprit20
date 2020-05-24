class OptionValue < ActiveRecord::Base

	belongs_to :option_type, inverse_of: :option_values
	acts_as_list
	after_create :update_new_variants

	has_many :option_value_variants
	has_many :variants, through: :option_value_variants
	VALID_COLOR_REGEX = /\A#?(?:[A-F0-9]{3}){1,2}\z/i
	validates :name, format: { with: VALID_COLOR_REGEX }, if: :color_is_on?

	with_options presence: true do
      validates :name
      validates :presentation, uniqueness: { scope: :option_type_id, allow_blank: true }
    end


    def update_new_variants
    	@ov_id = []			
    	@all_array = []		
    	@ov_id << id

    	@optiontype_of_ov = option_type.id 
    	@products_with_ot = Product.select{|p| p.option_types.ids.include? @optiontype_of_ov} 

    	@products_with_ot.each do |product| 
    		product.option_types.where.not(id: @optiontype_of_ov).each do |option_type| 
    			 @all_array << option_type.option_values.map(&:id) 
    		end

    		@new_variants_ov = @ov_id.product(*@all_array)

    		@new_variants_ov.each do |option_values|
 	           product.variants.create(:count_on_hand => "0", :cost_price => "5", :price =>  "5", :option_value_ids => option_values) 
          	end
        end
    end


    def check_if_any_variant_in_cart_has_the_option_value
    	if variants.any?
    		variants.each do |variant|
	 		if variant.line_items.empty?
	 		variant.delete
	 			return true
	 		else
	 		errors.add(:base, 'Line Items present')
	 			return false
			end	
		end
		else
			return true
		end
	end

	private

	def color_is_on?
	   option_type.color == true ? true : false
	end
end
