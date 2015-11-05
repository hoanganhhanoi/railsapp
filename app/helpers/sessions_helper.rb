module SessionsHelper

  # User login
  def log_in(user)
    session[:user_id] = user.id
    p :user_id
  end

  # user logout
  def log_out
    forget_user(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Return current user logged
  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Return true if user logged in
  def logged_in?
    !current_user.nil?
  end

  # Remember a user
  def remember_user(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forget user when user log out
  def forget_user(user)
    user.forget_user
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Return true if user is current user
  def current_user?(user)
    user == current_user
  end

  # Redirect to stored location
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
