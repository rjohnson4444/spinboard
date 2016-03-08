class Api::V1::LinksController < ApplicationController
  respond_to :json, :html

  def index
    respond_with Link.all
  end

  def create
    link = Link.new(link_params)

    if link.save
      respond_with link, location: api_v1_links_path(link)
    else
      render json: link.errors, status: 422
    end
  end

  private
    def link_params
      params.require(:link).permit(:title, :url)
    end
end
