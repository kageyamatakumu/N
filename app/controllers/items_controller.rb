class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show ]
  before_action :sns_share, only: %i[ show ]

  def index
    @q = Item.published.ransack(params[:q])
    @items = @q.result.includes([brand: :user]).order("RANDOM()")
  end

  def show
    if current_user
      history_item = @item.browsing_histories.new
      history_item.user_id = current_user.id

      if current_user.browsing_histories.exists?(item_id: "#{params[:id]}")
        old_history = current_user.browsing_histories.find_by(item_id: "#{params[:id]}")
        old_history.destroy
      end

      history_item.save

      history_stock_limit = 10
      histories = current_user.browsing_histories.all
      if histories.count > history_stock_limit
        histories[0].destroy
      end
    end
  end

  def likes
    @like_items = current_user.like_items.includes(:brand).order(created_at: :desc)
  end

  def histories
    @browsing_history_items = current_user.browsing_history_items.includes([brand: :user]).order(created_at: :desc)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :item_image, :item_image_cache, { dress_images: [] })
  end

  def set_item
    @brand = Brand.find(params[:brand_id])
    @item = @brand.items.find(params[:id])
  end

  def sns_share
    @sns_url = request.url
  end

end
