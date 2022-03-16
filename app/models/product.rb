class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader
  
  #if product is sold out display sold out sign
  def soldOut?
    if self.quantity == 0
      return true
    else
      return false
    end
  end

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

end
