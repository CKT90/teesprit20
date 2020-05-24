class VariantImage < ActiveRecord::Base

  belongs_to :variant
  belongs_to :image

end
