class OrderShippingsController < ApplicationController
  before_action :authenticate_user!,only: [:index, :create]
  def index 
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
    @item = Item.find(params[:item_id])
      @order_shipping = OrderShipping.new
  end

  def create 
    @item = Item.find(params[:item_id])
    @order_shipping = OrderShipping.new(order_shipping_params) 
    if @order_shipping.valid?
      @order_shipping.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end 
  end 

  def show
    @item = Item.find(params[:item_id])
  end

    private

    def order_shipping_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :city, :block_number, :building_name, :price,:telephone_number).merge(user_id: current_user.id,item_id:@item.id)

    end
  end
