class OrderShippingsController < ApplicationController
  before_action :authenticate_user!,only: [:index, :create, ]
  def index 
    gon.public_key = ENV["pk_test_223e01405558236168987833"]
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
      @order_shipping = OrderShipping.new
  end

  def create 
    @item = Item.find(params[:item_id])
    @order_shipping = OrderShipping.new(order_shipping_params) 
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV["pk_test_223e01405558236168987833"]
      render :index, status: :unprocessable_entity
    end 
  end 

  def show
    @item = Item.find(params[:item_id])
  end

    private

  def order_shipping_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :city, :block_number, :building_name, :telephone_number).merge(user_id: current_user.id,item_id:@item.id,token: params[:token])
  end

  def pay_item
    Payjp.api_key = "sk_test_c4e942e83e2afeabd2052d18"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount:@item.price,  # 商品の値段
      card: order_shipping_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
    end
  end