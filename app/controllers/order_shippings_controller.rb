class OrderShippingsController < ApplicationController

  def index 
    @item = Item.find(params[:item_id])
      @order_shipping = OrderShipping.new
  end

  def create 
    puts params 
    @order_shipping = OrderShipping.new(order_shipping_params)
  
    if@order_shipping.save
      redirect_to @order_shipping
    else
    flash.now[:alert] = @order_shipping.errors.full_messages
    render :index
    binding.pry
    end
  end 
    private

    def order_shipping_params
    params.require(:order_shipping).permit(:postal_code, :prefecture, :city, :house_number, :building_name, :price).merge(user_id: current_user.id)

    end
  end
