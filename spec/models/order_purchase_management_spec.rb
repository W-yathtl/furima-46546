require 'rails_helper'

RSpec.describe OrderPurchaseManagement, type: :model do
  describe '商品購入情報の保存' do
    before do
      # テスト用のユーザーと商品を作成
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      # OrderPurchaseManagementのインスタンスを生成
      @order_purchase_management = FactoryBot.build(:order_purchase_management, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_purchase_management).to be_valid
      end
      it 'detail_addressは空でも保存できること' do
        @order_purchase_management.detail_address = ''
        expect(@order_purchase_management).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @order_purchase_management.token = nil
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと保存できないこと' do
        @order_purchase_management.postal_code = ''
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_purchase_management.postal_code = '1234567'
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @order_purchase_management.prefecture_id = 1
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @order_purchase_management.city = ''
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_purchase_management.address = ''
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("Address can't be blank")
      end
      it 'phoneが空だと保存できないこと' do
        @order_purchase_management.phone = ''
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("Phone can't be blank")
      end
      it 'phoneが10桁未満だと保存できないこと' do
        @order_purchase_management.phone = '090123456'
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include('Phone is invalid')
      end
      it 'phoneが12桁以上だと保存できないこと' do
        @order_purchase_management.phone = '090123456789'
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include('Phone is invalid')
      end
      it 'phoneに半角数字以外が含まれている場合は保存できないこと' do
        @order_purchase_management.phone = '090-1234-5678'
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include('Phone is invalid')
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_purchase_management.user_id = nil
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_purchase_management.item_id = nil
        @order_purchase_management.valid?
        expect(@order_purchase_management.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
