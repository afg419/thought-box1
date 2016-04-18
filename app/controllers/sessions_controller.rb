class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in #{@user.email}"
      redirect_to links_path
    else
      flash.now[:error] = "Incorrect username password combination"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
