module ProductsHelper

  def filter_option(product, options) #product object and options in an array of string
  	all_options = Hash[product.variants.map{|v| [v.id, v.option_values.ids]}] #map all product variants with Hash, key=variant.id, values=array of option value ids
  	variant_id = all_options.select{|k,v| v.sort! == options.map(&:to_i).sort! && v.size == options.size }.keys # find which variant id (key), change to array to integer and select. sort to make both position same. both must same size
  	selected_variant = Variant.find(variant_id)
  	return selected_variant[0]
  end
  
end
