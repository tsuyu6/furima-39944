class ItemsController < ApplicationController
  def index
    
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
  private
  def item_params
    params.require(:item).permit(:category_id,:condition_id,:shipping_charge_id,:prefecture_id,:item_name,:price,:information,:delively_day_id,:image).merge(user_id: current_user.id)
  end 
end   