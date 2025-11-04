class OrderPurchaseManagement
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :detail_address, :phone, :token

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city
    validates :address
    validates :phone, format: { with: /\A\d{10,11}\z/, message: "is invalid" }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    # 購入管理情報を保存
    purchase_management = PurchaseManagement.create(user_id: user_id, item_id: item_id)
    # 配送先情報を保存
    Order.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      detail_address: detail_address,
      phone: phone,
      purchase_management_id: purchase_management.id
    )
  end
end