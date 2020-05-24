class ProductCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :product

  validates :product, :category, presence: true

end
