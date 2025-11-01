class PurchaseManagementsController < ApplicationController
  before_action :authenticate_user!

  def create
    @purchase_management = PurchaseManagement.new(purchase_management_params)
    @purchase_management.user = current_user # ユーザーを紐付ける

    if @purchase_management.save
      redirect_to root_path, notice: "購入管理が作成されました"
    else
      render :new
    end
  end

  private

  def purchase_management_params
    params.require(:purchase_management).permit(:item_id)
  end
end
