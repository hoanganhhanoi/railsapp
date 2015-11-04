class UsersController < ApplicationController

  # Set New User
  def new
    @user = User.new
  end

  # Find user with condition id
  def show
    @user = User.find(params[:id])
  end

  # Create user
  def create
    @user = User.new(user_params)
    if @user.save
    else
      render 'new'
    end
  end

  private

    # Get params from views 
    def user_params
      return params.require(:user).permit(:name, :email, :password,
                                          :password_confirmation)
    end

end
