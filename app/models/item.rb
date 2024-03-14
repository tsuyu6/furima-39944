class Item < ApplicationRecord
  validates :category_id,:condition_id,:dalivaly_day_id,:prefecture_id,:shippingcharge_id, numericality: { other_than: 1 }
  
  has_one_attached :image
  belongs_to :category_id
  belongs_to :condition_id
  belongs_to :dalivaly_day_id
  belongs_to :prefecture_id
  belongs_to :shippingcharge_id
  
end
