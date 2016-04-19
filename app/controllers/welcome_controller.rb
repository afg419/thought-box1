class WelcomeController < ApplicationController

  before_action :to_links_if_logged_in

  def index

  end

private

  def to_links_if_logged_in
    if current_user
      redirect_to links_path
    end
  end

end
