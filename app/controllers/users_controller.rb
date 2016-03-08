class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.email}."
      redirect_to links_path
    else
      flash[:errors] = @user.errors.full_messages.join(",")
      redirect_to new_user_path
    end
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
