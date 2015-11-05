class AccountActivationsController < ApplicationController

  def edit
    user = User.find_buy(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.active
      log_in user
      flash[:success] = "Tai khoan da duoc kich hoat"
      redirect_to user
    else
      flash[:danger]  = "Link xac nhan ko dung"
      redirect_to root_url
    end
  end

end
