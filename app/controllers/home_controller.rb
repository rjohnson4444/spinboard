class HomeController < ApplicationController
  def home
    if current_user
      redirect_to links_path
    else
      redirect_to home_path
    end
  end

  def index

  end
end
