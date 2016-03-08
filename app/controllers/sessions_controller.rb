class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:login] = "#{@user.email} has logged in."
      redirect_to links_path
    else
      flash[:error] = "Invalid. Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
