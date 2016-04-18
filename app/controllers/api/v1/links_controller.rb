class Api::V1::LinksController < ApplicationController
  def index
    render json: current_user.links
  end

  def update
    link = Link.find(params[:id])
    link.update_attributes(link_params)
    if link.save
      render json: link
    else
      render json: false
    end
  end

private

  def link_params
    params.require(:link).permit(:read, :title, :url)
  end
end
