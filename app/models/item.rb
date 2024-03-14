class Item < ApplicationRecord
  validates :category_id,:condition_id,:delively_day_id,:prefecture_id,:shipping_charge_id, numericality: { other_than: 1 }
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :delively_day
  belongs_to :prefecture
  belongs_to :shipping_charge
  
end
