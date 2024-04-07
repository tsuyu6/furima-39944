class OrderShipping
  include ActiveModel::Model
  attr_accessor :item_id,:user_id, :post_code , :prefecture_id,:building_name, :city, :block_number,:telephone_number

  with_options presence: true do
   
    validates :user_id 
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city 
    validates :block_number
    validates :building_name 
    validates :telephone_number
    end
  
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    # 寄付情報を保存し、変数donationに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    ShippingInformation.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture_id, city: city, block_number: block_number, building_name: building_name, telephone_number: telephone_number)
  end
end