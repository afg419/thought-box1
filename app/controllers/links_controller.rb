class LinksController < ApplicationController
  before_action :authenticate_logged_in

  def index
    @links = current_user.links
    @link = Link.new
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      flash[:notice] = "Created new link!"
      redirect_to links_path
    else
      flash.now[:error] = "Invalid link"
      @links = Link.all
      render :index
    end
  end

private

  def link_params
    params.require(:link).permit(:title, :url)
  end

  def authenticate_logged_in
    redirect_to root_path unless current_user
  end
end
