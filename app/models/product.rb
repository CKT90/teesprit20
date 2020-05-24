class Product < ActiveRecord::Base

	#include Elasticsearch::Model
  	#include Elasticsearch::Model::Callbacks

	as_enum :state, %i{discontinued available}

	before_destroy :ensure_variants_not_referenced_by_any_line_item
	after_validation :uppercase_product_number

    after_create :create_all_variants
    after_update :update_status

    validate :discontinue_date_cannot_be_in_the_past
	validates :title, :description, presence: true, uniqueness: true
	validates :option_types, presence: true

	DATE_REGEX = /((19|20)\d\d)-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/i

	validates :available_on, format: { with: DATE_REGEX }, :if => :available_on_changed?, allow_blank: true 
	validates :discontinue_on, format: { with: DATE_REGEX }, :if => :discontinue_on_changed?, allow_blank: true

	with_options dependent: :destroy do
		has_many :images, -> { order(:position) }
		has_many :product_option_types, inverse_of: :product
		has_many :variants
	end

	has_many :option_types, -> { order(:position) }, through: :product_option_types	
	accepts_nested_attributes_for :images, allow_destroy: true


    extend FriendlyId
    friendly_id :number, slug_column: :number, use: [:slugged,:finders]
    include NumberGenerator.new(prefix: 'P')


	def should_generate_new_friendly_id?
  		number_changed?
	end

    def find_variant(selected_option_ids)
    	 variants.includes(:option_values).select{|v| v.option_values.pluck(:id).sort! == selected_option_ids.map(&:to_i).sort! && v.option_values.size == selected_option_ids.size }.first
   	end

  	def update_status
  		if discontinue_on.present? && available_on.present?
	  		if discontinue_on >= Time.now && Date.today >= available_on
		  		update_column(:state_cd, 1)
		  	else 
		  		update_column(:state_cd, 0)
		  	end
  		else
		  	update_column(:state_cd, 0)
		end
  	end

 	private

  	def create_all_variants
		@all_array = []
		@mixed_array = []

	    option_types.each do |option_type|
	       @all_array << option_type.option_values.map(&:id)
	    end

	    @mixed_array << @all_array[0].product(*@all_array.drop(1))

	    @rep_arr = @mixed_array.flatten(1)

	    @rep_arr.each do |option_v|
	       variants.create(:count_on_hand => "5", :cost_price => "30", :price =>  "49", :option_value_ids => option_v)
	    end
    end

   	def uppercase_product_number
    	number.upcase!
    	# return nil if nothing to upcase
  	end
 
    def discontinue_date_cannot_be_in_the_past
	  	unless discontinue_on.nil? || available_on.nil? 
		    if discontinue_on <= available_on
		      errors.add(:discontinue_on, "can't be less than available date")
		    end
		end
  	end  

	 # ensure that there are no line items referencing this product (before deleted, make sure not present in any cart)
	def ensure_variants_not_referenced_by_any_line_item
	 	variants.each do |variant|
	 		if variant.line_items.empty?
	 			return true
	 		else
	 		errors.add(:base, 'Line Items present')
	 			return false
			end	
		end
	end

end

#Product.import(force: true)