class UrlsController < ApplicationController
  def index
    @url = Url.new
  end

  def show
    @url = Url.find(params[:id])
  end

  def visit
  end

  def new
    @url = Url.new
  end
  
  def create
  end

  def destroy
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:long_url, :short_url, :visits)
  end
end
