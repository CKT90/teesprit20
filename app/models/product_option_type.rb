class ProductOptionType < ActiveRecord::Base
  belongs_to :option_type
  belongs_to :product
  #after_update :check_status

  validates :product, :option_type, presence: true


  def check_status 
  	product = Product.find_by(id: self.product_id)
  	option_type = OptionType.find_by(id: self.option_type_id)


  	@variant_ids = []
  	@ov_ids = []

    product.variants.each do |pv|
        @variant_ids << pv.id
    end


    option_type.option_values.each do |ov|
        @ov_ids << ov.id
    end


    @ov_ids.each do |kap|
    	@variant_ids.each do |v_id|
  			OptionValueVariant.where(variant_id: v_id).where(option_value_id: kap).find_each do |opv|
  				
			  		if hidden == true 
			  			opv.update(hidden: true)
			  		else
			  	  	opv.update(hidden: false)
					end

  			end
  		end
  	end



  end
end


