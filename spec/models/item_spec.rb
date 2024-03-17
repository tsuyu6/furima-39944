require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
    end

# 正常系
# ・全ての項目が入力されていれば出品できる

# 異常系
# ■商品画像
# ・商品画像が空では出品出来ない（@item.imageには空文字ではなくnilを代入する）
it "画像が空では出品出来ない" do
  @item.image = ""
  @item.valid?
  expect(@item.errors.full_messages).to include("image can't be blank")

# ■商品名
# ・商品名が空では出品できない
it "商品名が空では出品できない" do
  @item.item_name = ""
  @item.valid?
  expect(@item.errors.full_messages).to include("item_name can't be blank")
end

# ■商品説明
# ・商品説明が空では出品できない
it "商品説明が空では出品出来ない" do
  @item.information = ""
  @item.valid?
  expect(@item.errors.full_messages).to include("information can't be blank")
end

# ■ActiveHash５項目
# ・カテゴリーに「---」が選択されている場合は出品できない
@item.category _id= ‘0’ do
  @item.valid?
  expect(@item.errors.full_messages).to include("category can't be blank")
end

  # ・商品の状態に「---」が選択されている場合は出品できない
@item.condition _id= ‘0’ do
  @item.valid?
  expect(@item.errors.full_messages).to include("conditin can't be blank")
end

  # ・配送料の負担に「---」が選択されている場合は出品できない
  @item.shipping_charge _id= ‘0’ do
  @item.valid?
  expect(@item.errors.full_messages).to include("shipping_charge can't be blank")
end

# ・発送元の地域に「---」が選択されている場合は出品できない
@item.prefecture _id= ‘0’ do
@item.valid?
expect(@item.errors.full_messages).to include("prefecture can't be blank")
end

# ・発送までの日数に「---」が選択されている場合は出品できない
@item.delively_day _id= ‘0’ do
@item.valid?
expect(@item.errors.full_messages).to include("delively_day can't be blank")
end

# ■価格 
# ・価格が空では出品できない
@item.price _id= ‘0’ do
@item.valid?
expect(@item.errors.full_messages).to include("price can't be blank")
end

# ・価格に半角数字以外が含まれている場合は出品できない（※半角数字以外が一文字でも含まれていれば良い）
@item.price = 'ABCDE１２３４５' do
@item.valid?
expect(@item.errors.full_messages).to include("price には半角数字のみを設定してください")
end

# ・価格が300円未満では出品できない
@item.price = '1〜299' do
@item.valid?
expect(@item.errors.full_messages).to include("price には300円以上を設定してください")
end

# ・価格が9_999_999円を超えると出品できない
@item.price = '9_999_999〜' do
@item.valid?
expect(@item.errors.full_messages).to include("price には999万円以下を設定してください")
end

# ■出品者情報
# ・userが紐付いていなければ出品できない
@item.user = 'user' do
@item.valid?
expect(@item.errors.full_messages).to include("user には同じ名前を設定してください")
end

# 上のやつを参考に▫️を作る