class Order < ApplicationRecord
has_one :order_shipping_information
belongs_to :user
belongs_to :item
has_one :shipping_information
end