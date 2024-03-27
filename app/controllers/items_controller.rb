class ItemsController < ApplicationController
  before_action :authenticate_user!,only: [:new]
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

  def show
        @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])

    unless current_user.id == @item.user_id 
      redirect_to action: :index
    end

  end

  def update
    @item = Item.find(params[:id])
    if@item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:category_id,:condition_id,:shipping_charge_id,:prefecture_id,:item_name,:price,:information,:delively_day_id,:image).merge(user_id: current_user.id)
  end 

  def move_to_index
    @item = Item.find(params[:id])  
  end
end