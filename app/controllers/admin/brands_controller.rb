class Admin::BrandsController < Admin::BaseController
  before_action :set_brand, only: %i[edit update show ]
  before_action :verify_access, only: %i[ show edit update ]

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    @brand.user_id = current_user.id
    if @brand.save
      redirect_to  admin_brand_path(@brand)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @brand.update(brand_params)
      redirect_to admin_brand_path(@brand)
    else
      render :edit
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name,:brand_description, :instagram_user_name, :start_up, :brand_image, :brand_image_cache, :instagram_image, :instagram_image_cache )
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def verify_access
    redirect_to sessions_path, danger: 'アクセス許可できません' unless current_user.my_object?(@brand)
  end

end
