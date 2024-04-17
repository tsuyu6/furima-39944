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

      
      it 'building_nameは空でも保存できること' do
        @order_shipping.building_name = ''
        expect(@order_shipping).to be_valid
      end
    end

      context '内容に問題がある場合' do
        it 'post_codeが空だと保存できないこと' do
          @order_shipping.post_code = ''
          @order_shipping.valid?
          expect(@order_shipping.errors.full_messages).to include("Post code can't be blank")
        end
        
        it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
          @order_shipping.post_code = '1234567'
          @order_shipping.valid?
          expect(@order_shipping.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
        end
        
        it 'cityは空でも保存できること' do
          @order_shipping.city = ''
          @order_shipping.valid?
          expect(@order_shipping.errors.full_messages).to include("City can't be blank")
        end


        it 'block_numberは空でも保存できること' do
          @order_shipping.block_number = ''
          @order_shipping.valid?
          expect(@order_shipping.errors.full_messages).to include("Block number can't be blank")
        end


        it 'prefectureを選択していないと保存できないこと' do
          @order_shipping.prefecture_id = 0
          @order_shipping.valid?
          expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
        end
        
        it 'userが紐付いていないと保存できないこと' do
          @order_shipping.user_id = nil
          @order_shipping.valid?
          expect(@order_shipping.errors.full_messages).to include("User can't be blank")
        end
      
        it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @order_shipping.telephone_number = "09012345678"
        expect(@order_shipping).to be_valid
        end

        it '電話番号は、9桁以下の場合購入できない' do
        @order_shipping.telephone_number = "090123456"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Telephone number TelePhoneNumber must be 10or11 digit Half-width numbers")
      end
      
      it '電話番号は、12桁の場合購入できない' do
      @order_shipping.telephone_number = "090123456789"
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Telephone number TelePhoneNumber must be 10or11 digit Half-width numbers")
    end

      it '電話番号は全角の場合購入できない' do
      @order_shipping.telephone_number = "０９０１２３４５６７８９"
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Telephone number TelePhoneNumber must be 10or11 digit Half-width numbers")
    end

      it '電話番号がないと購入できない' do
      @order_shipping.telephone_number = nil
      @order_shipping.valid?
      expect(@order_shipping.errors.full_messages).to include("Telephone number can't be blank")
    end


      it "tokenが空では登録できないこと" do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end