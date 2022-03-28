class ItemsController < ApplicationController
    before_action :set_item, only: %i[ show ]

    def index
        @q = Item.ransack(params[:q])
        @items = @q.result.includes([brand: :user]).order("RANDOM()")
    end

    def show; end

    def likes
        @like_items = current_user.like_items.includes(:brand).order(created_at: :desc)
    end

    private

    def item_params
        params.require(:item).permit(:name, :description, :item_image, :item_image_cache, { dress_images: [] })
    end

    def set_item
        @brand = Brand.find(params[:brand_id])
        @item = @brand.items.find(params[:id])
    end
end
