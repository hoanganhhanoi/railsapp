class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # use sessionhelper
  include SessionsHelper

  private 

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Yeu cau dang nhap de su dung dich vu."
        redirect_to login_url
      end
    end
  
end
