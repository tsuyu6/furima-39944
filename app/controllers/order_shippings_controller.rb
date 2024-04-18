class OrderShippingsController < ApplicationController
  before_action :authenticate_user!,only: [:index, :create]
  before_action :set_item, only:[:index ,:create]
  def set_item
   end
 
 
  def index 
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
      @order_shipping = OrderShipping.new
  end

  def create 
    @order_shipping = OrderShipping.new(order_shipping_params) 
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end 
  end 

  

    private
    @item = Item.find(params[:item_id])

  def order_shipping_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :city, :block_number, :building_name, :telephone_number).merge(user_id: current_user.id,item_id:@item.id,token: params[:token])
  end

  def pay_item
    Payjp.api_key = "PAYJP_SECRET_KEY"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount:@item.price,  # 商品の値段
      card: order_shipping_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

 