require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @item = FactoryBot.build(:item)
  end
      # 正常系

      describe '商品出品機能のテスト' do
        context '正常系' do
      it "全ての項目が入力されていれば出品できる" do
        expect(@item).to be_valid
      end
    end

      # 異常系
      # ■商品画像
      # ・商品画像が空では出品出来ない（@item.imageには空文字ではなくnilを代入する）
      context '異常系' do
      it "画像が空では出品出来ない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      # ■商品名
      # ・商品名が空では出品できない
      it "商品名が空では出品できない" do 
        @item.item_name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      # ■商品説明
      # ・商品説明が空では出品できない
      it "商品説明が空では出品出来ない" do
        @item.information = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Information can't be blank")
      end

      # ■ActiveHash５項目
      it "カテゴリーに「---」が選択されている場合は出品できない" do
        @item.category_id = 0 
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 0")
      end

      it "商品の状態に「---」が選択されている場合は出品できない" do
        @item.condition_id = 0 
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 0")
      end

      it "配送料の負担に「---」が選択されている場合は出品できない" do
        @item.shipping_charge_id = 0 
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge must be other than 0")
      end

      it "発送元の地域に「---」が選択されている場合は出品できない" do
        @item.prefecture_id = 0 
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
      end

      it "発送までの日数に「---」が選択されている場合は出品できない" do
        @item.delively_day_id = 0 
        @item.valid?
        expect(@item.errors.full_messages).to include("Delively day must be other than 0")
      end

      # ■価格 
      it "価格が空では出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it "価格に半角数字以外が含まれている場合は出品できない（※半角数字以外が一文字でも含まれていれば良い）" do
        @item.price = 'ABCDE１２３４５'  
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end

      it "価格が300円未満では出品できない" do
        @item.price = 299 
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end

      it "価格が9_999_999円を超えると出品できない" do
        @item.price = 10_000_000 
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end

      # ■出品者情報
      it "userが紐付いていなければ出品できない" do
        @item.user = nil 
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    
      it "itemがuserに紐づいていなければ登録できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end

