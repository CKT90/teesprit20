class OptionType < ActiveRecord::Base

  with_options dependent: :destroy, inverse_of: :option_type do
    has_many :option_values, -> { order(:position) }
    has_many :product_option_types
  end
    
  has_many :products, through: :product_option_types
  accepts_nested_attributes_for :option_values, reject_if: lambda { |ov| ov[:name].blank? || ov[:presentation].blank?}, allow_destroy: true, update_only: true

  with_options presence: true do
      validates :name
      validates :presentation, :uniqueness => {:message => "already exist"} 
  end

end
