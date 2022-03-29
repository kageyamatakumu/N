class LikesController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    current_user.like(item)
    redirect_back(fallback_location: brand_item_path(item.brand, item))
  end

  def destroy
    item = current_user.likes.find(params[:id]).item
    current_user.unlike(item)
    redirect_back(fallback_location: brand_item_path(item.brand, item))
  end
end
