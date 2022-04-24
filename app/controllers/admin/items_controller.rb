class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: %i[edit update show destroy ]
  before_action :verify_access, only: %i[ show edit update destroy]

  def index
    @brand = Brand.find(params[:brand_id])
    @items = @brand.items.all.order(created_at: :desc)
  end

  def new
    @brand = Brand.find(params[:brand_id])
    @item = Item.new
  end

  def create
    @brand = Brand.find(params[:brand_id])
    @item = @brand.items.new(item_params)
    if @item.save
      redirect_to admin_brand_item_path(@brand, @item)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to admin_brand_item_path(@brand, @item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy!
    redirect_to admin_brand_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :item_image, :item_image_cache, { dress_images: [] })
  end

  def set_item
    @brand = Brand.find(params[:brand_id])
    @item = @brand.items.find(params[:id])
  end

  def verify_access
    redirect_to root_path, danger: 'アクセス許可できません' unless current_user.my_object?(@brand)
  end

end
