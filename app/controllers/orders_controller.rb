class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_sold, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_owner, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_purchase_management = OrderPurchaseManagement.new
  end

  def create
    @order_purchase_management = OrderPurchaseManagement.new(purchase_management_params)
    if @order_purchase_management.valid?
      pay_item
      @order_purchase_management.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end
 
  private

  # def order_params
  #   params.require(:order).permit(:price).merge(token: params[:token])
  # end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_management_params
    params.require(:order_purchase_management).permit(:postal_code, :prefecture_id, :city, :address, :detail_address, :phone).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp.default_options = { ssl_ca_file: "/etc/ssl/certs/ca-certificates.crt" }

  Payjp::Charge.create(
    amount: @item.price,
    card: purchase_management_params[:token],
    currency: 'jpy'
  )
  end

  def redirect_if_sold
    redirect_to root_path if @item.purchase_management.present?
  end

  def redirect_if_owner
    redirect_to root_path if current_user.id == @item.user_id
  end
end
