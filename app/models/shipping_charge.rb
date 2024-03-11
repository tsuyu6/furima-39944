class Shipping_charge < ActiveHash::Base
validates :shipping_charge, presence: true 
  self.data = [
  { id: 1, shipping_charge_id: '---' },
  { id: 2, shipping_charge_id: '着払い（購入者負担）' },
  { id: 3, shipping_charge_id: '送料込み（出品者負担）' }, 
  ]

    include ActiveHash::Associations
    extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :articles
  
end