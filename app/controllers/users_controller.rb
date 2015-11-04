class UsersController < ApplicationController

  # Check log in before access to edit, update
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy


  def index
    @user = User.paginate(page: params[:page])
  end

  # Set New User
  def new
    @user = User.new
  end

  # Find user with condition id
  def show
    @user = User.find(params[:id])
  end

  # Edit inform user
  def edit
    @user = User.find(params[:id])
  end

  # Create user
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Chuc mung ban da dang ki thanh cong!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # Update info user
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Thay doi thong tin thanh cong"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Destroy user
  def destroy
    
    if User.find(params[:id]).destroy
      flash[:success] = "Xoa thanh vien thanh cong"
    else
      flash[:danger]  = "Co van de trong phien giao dich"
    end

    redirect_to users_url

  end

  private

    # Get params from views 
    def user_params
      return params.require(:user).permit(:name, :email, :password,
                                          :password_confirmation)
    end

    # Confirm user logged in
    def logged_in_user
      if !logged_in?
        store_location
        flash[:danger] = "Yeu cau dang nhap de su dung dich vu."
        redirect_to login_url
      end
    end

    # Confirm correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
