class UrlsController < ApplicationController
  def index
    @url = Url.new
  end

  def show
    @url = Url.find(params[:id])
  end

  def visit
    @url = Url.find_by(short_url: params[:id])
    @url.visits += 1
    @url.save
    redirect_to @url.long_url
  end

  def new
    @url = Url.new
  end
  
  def create
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy
    respond_to do |format|
      format.html { redirect_to sites_url, notice: 'Site has been annihilated.' }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:long_url, :short_url, :visits)
  end
end