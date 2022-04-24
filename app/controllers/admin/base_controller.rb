class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :check_owner
  before_action :require_login

  private

  def check_owner
    unless current_user.class == Owner
      redirect_to root_path
    end
  end

  def not_authenticated
    redirect_to admin_owner_login_path
  end

end
