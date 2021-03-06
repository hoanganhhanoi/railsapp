class SessionsController < ApplicationController

  # Set new Session
  def new
  end

  # Create new Session
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember_user(user) 
                                            : forget_user(user)
        redirect_back_or user 
      else
        message  = "Tai khoan chua duoc kick hoat"
        message += "Kiem tra email de kich hoat tai khoan"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = "Email hoac mat khau khong dung"
      render 'new'
    end
  end

  # Destroy session
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
