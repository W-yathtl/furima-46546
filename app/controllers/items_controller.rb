class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :redirect_if_not_owner, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end
  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id).merge(user_id: current_user.id)
  end

    def set_item
    @item = Item.find(params[:id])
  end

  def redirect_if_not_owner
      # 出品者でない、または売却済みの場合はトップページへリダイレクト
    redirect_to root_path if current_user.id != @item.user_id || @item.purchase_management.present?
  end    
end
