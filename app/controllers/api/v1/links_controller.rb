class Api::V1::LinksController < ApplicationController

  def index
    render json: current_user.links
  end

end
