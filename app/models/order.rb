class Order < ApplicationRecord
  attr_accessor :token
belongs_to :user
belongs_to :item
has_one :shipping_information
validates :token, presence: true
end