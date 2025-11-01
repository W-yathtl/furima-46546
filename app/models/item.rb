class Item < ApplicationRecord
  # ActiveStorage
  has_one_attached :image

  # Association
  belongs_to :user
  has_one :purchase_management

  # ActiveHash の関連付け
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  # バリデーション
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :image
  end

  # ActiveHash のidが1（---）の時は登録できない
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  # 価格の範囲バリデーション
  validates :price, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 300, 
    less_than_or_equal_to: 9_999_999, 
    message: "は¥300〜¥9,999,999の間で入力してください" 
  }
end
