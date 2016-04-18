class Api::V1::LinksController < ApplicationController

  def index
    render json: current_user.links
  end

  def update
    link = Link.find(params[:id])
    link.update(read: params[:read])
    render json: link
  end

end
