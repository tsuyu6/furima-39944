class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #パスワード半角英数字混合のバリデーション
         PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
         validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' 
         #名字と名前の全角日本語のバリデーション
         with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
          validates :first_name
          validates :family_name
        end
        #全角カタカナのの日本語バリデーション
        with_options presence: true, format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."} do
          validates :first_name_kana
          validates :family_name_kana

        end
        #空欄だったら登録できないバリデーション
        with_options presence: true do
          validates :nickname
          validates :birthday  
    
      end

      has_many :items
      has_many :orders

    end
