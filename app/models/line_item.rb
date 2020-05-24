class LineItem < ActiveRecord::Base
  belongs_to :variant
  belongs_to :cart, touch: true
  belongs_to :order

  def choice_list(values, variant_id)
    @choice = []
  	values.each do |ov|
  		unless OptionValueVariant.find_by(option_value_id: ov, variant_id: variant_id).hidden?
  			optionvalue = OptionValue.find_by(id: ov)
  			@choice << optionvalue.name
  		end
  	end
  	update(:selection, @choice.join(", "))
  end

  def total_price
	 variant.price * quantity
  end

  def total_final_price
    final_price * quantity
  end
  
end
