require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id,item_id: item.id)
  end
  describe '寄付情報の保存' do

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping).to be_valid
      end

      it 'cityは空でも保存できること' do
        @order_shipping.city = ''
        expect(@order_shipping).to be_valid
      end

      it 'house_numberは空でも保存できること' do
        @order_shipping.house_number = ''
        expect(@order_shipping).to be_valid
      end
      
      it 'building_nameは空でも保存できること' do
        @order_shipping.building_name = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      
      it 'prefectureを選択していないと保存できないこと' do
        @order_shipping.prefecture = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it 'priceが空だと保存できないこと' do
        @order_shipping.price = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Price can't be blank")
      
      end
      it 'priceが全角数字だと保存できないこと' do
        @order_shipping.price = '２０００'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Price is invalid')
      end
      
      it 'priceが1円未満では保存できないこと' do
        @order_shipping.price = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Price is invalid')
      end
      
      it 'priceが1,000,000円を超過すると保存できないこと' do
        @order_shipping.price = 1000001
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Price is invalid')
      end
      
      it 'userが紐付いていないと保存できないこと' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end