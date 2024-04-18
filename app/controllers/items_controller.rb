class ItemsController < ApplicationController
  before_action :authenticate_user!,only: [:new, :create ,:edit ,:destroy]
  before_action :set_item,only: [:show ,:edit ,:update, :destroy]
  def index 
    @items = Item.order("created_at DESC")
  end
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # 保存できたらトップページに遷移する。
      redirect_to root_path
    else
      render :new,status: :unprocessable_entity
    end
  end

  def destroy
      if user_signed_in? && current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
      else
      redirect_to root_path
      end
  end

  def show   
  end

  def edit
      if current_user.id != @item.user_id || @item.order.present?
      
      redirect_to root_path
    end
  end

  def update
    if@item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  
  private
  def item_params
    params.require(:item).permit(:category_id,:condition_id,:shipping_charge_id,:prefecture_id,:item_name,:price,:information,:delively_day_id,:image).merge(user_id: current_user.id)
  end 

  # def move_to_index
  #   @item = Item.find(params[:id])  
  # end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
