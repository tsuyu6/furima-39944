class Item < ApplicationRecord
  validates :category_id,:condition_id,:delively_day_id,:shipping_charge_id,:prefecture_id,numericality: { other_than: 0 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached :image
  
  
  belongs_to :category 
  
  
  belongs_to :condition
  
  
  belongs_to :delively_day
  

  belongs_to :shipping_charge


  belongs_to :prefecture
  
  
  # 300以上、9,999,999以下の整数を許可する
validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid"}
  #空欄
has_one :order
belongs_to :user
#空欄

#空欄だったら登録できないバリデーション
with_options presence: true do
  validates :item_name
  validates :price 
  validates :image
  validates :information
  end
end
