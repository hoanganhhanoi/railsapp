module SessionsHelper

  # User login
  def log_in(user)
    session[:user_id] = user.id
  end

  # user logout
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Return current user logged
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Return true if user logged in
  def logged_in?
    !current_user.nil?
  end

end
