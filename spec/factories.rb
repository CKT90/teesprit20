FactoryBot.define do
  
  factory :product do
  	factory :product_1 do
    	title 			{"Product_1"}
    	description 	{"product description 1"}
    	# factory :product_with_variant do
		#    after(:build) do |product_1|
		#      create(:variant_1, product: product_1)
		#    end
		# end
    end

  	factory :product_2 do
    	title 			{"Product_2"}
    	description 	{"product description 2"}
    end 
  end


  factory :option_type do
  	factory :ot_1 do
	    id 				{ 1 }
	    name 			{"ot1"}
	    presentation 	{"ot1"}

		transient do
			option_values_count { 2 }
		end

	    after(:create) do |ot, evaluator|
	      create_list(:option_value, evaluator.option_values_count, option_type: ot)
	    end #create list, you can just replace "evaluator.option_values_count" with number such as "2"
  	end

   	factory :ot_2 do
	    id 				{ 2 }
	    name 			{"ot2"}
	    presentation 	{"ot2"}

		transient do
			option_values_count { 4 }
		end

	    after(:create) do |ot, evaluator|
	      create_list(:option_value, evaluator.option_values_count, option_type: ot)
	    end
  	end
  end


  factory :variant do
  	  # factory :variant_1 do
  	  # end
  end

  factory :option_value do
  	  sequence(:id) 			{ |n| "#{n}" }
  	  sequence(:name) 			{ |n| "ov_#{n}" }
  	  sequence(:presentation) 	{ |n| "ov_#{n}" }
  	  option_type
  end

end