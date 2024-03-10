require 'rails_helper'

RSpec.describe User, type: :model do
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

      it 'passwordが129文字以上では登録できない' do
        @user.password =  Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation =  @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

        it '重複したemailが存在する場合は登録できない' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'emailは空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

        it '半角英語のみでは登録できない' do
          @user.password = 'abcdefg'
          @userpassword_confirmation = 'abcdefg'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
        
        it '半角数字のみでは登録できない' do
          @user.password = '12345'
          @user.password_confirmation = '12345'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      
      it '全角英語を利用できない' do
          @user.password = 'ABCDE'
          @user.password_confirmation = 'ABCDE'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      
      it '全角数字を利用できない' do
          @user.password = '１２３４５'
          @user.password_confirmation = '１２３４５'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

        it '氏名の苗字入力が必須である' do
          @user.family_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name can't be blank")
      end    
      
      it '氏名の名前入力が必須である' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '苗字のカナ入力が必須である' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end         

      it '名前のカナ入力が必須である' do
          @user.family_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Family name kana can't be blank")  
      end

      it '氏名の苗字に英字が含まれると登録できない' do
        @user.family_name = 'abvdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
      end    
      
      it '氏名の名前に英字が含まれると登録できない' do
      @user.family_name = 'abvdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
    end  
      
      it '氏名の名前に英字が含まれると登録できない' do
      @user.family_name = 'abvdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
    end      
      
      it '苗字のカナに英字が含まれると登録できない' do
      @user.family_name = 'abvdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
    end   

      it '名前のカナに英字が含まれると登録できない' do
      @user.family_name = 'abvdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 全角文字を使用してください")
    end  
      
      it '生年月日の入力が必須である' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")  
      end
    end
  end
end

