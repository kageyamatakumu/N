class LikesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    current_user.like(@item)
    # ajax(非同期処理に移行)
    # redirect_back(fallback_location: brand_item_path(item.brand, item))
  end

  def destroy
    @item = current_user.likes.find(params[:id]).item
    current_user.unlike(@item)
    # ajax(非同期処理に移行)
    # redirect_back(fallback_location: brand_item_path(item.brand, item))
  end

end
