class Admin::BaseController < ApplicationController
before_action :logged_in_user
layout :render_admin_layout
before_action :admin_required


def admin_required
  unless current_user.admin == true
    redirect_to store_url
  end
end

private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def render_admin_layout
    if logged_in? && current_user.admin == true
      "admin/admin"
    end
  end

end
