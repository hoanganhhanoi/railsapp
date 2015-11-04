class SessionsController < ApplicationController

  # Set new Session
  def new
  end

  # Create new Session
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    else
      flash[:danger] = "Email hoac mat khau khong dung"
      render 'new'
    end
  end

  # Destroy session
  def destroy
  end

end
