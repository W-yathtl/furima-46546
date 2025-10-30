class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :nickname, presence: true
  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, presence: true

  # 名前：全角（漢字・ひらがな・カタカナ）
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  # カナ：全角カタカナ
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }

  # パスワード：半角英数字混合
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数字を両方含めて入力してください' }
end
