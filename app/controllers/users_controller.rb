class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Created account and logged in #{@user.email}"
      redirect_to links_path
    else
      flash[:notice] = "Something blew up"
      render :new
    end
  end

  def show
    @user = current_user
  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
