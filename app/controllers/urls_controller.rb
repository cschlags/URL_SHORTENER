class UrlsController < ApplicationController
  def index
    redirect_to root_path
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
    # long_url: site_params[:long_url]
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to url_path(@url), notice: 'Url has been created! Tahdah!' }
        format.json
      else
        format.html { render action: 'new' }
        format.json { render :json => { :error => @url.errors.full_messages }, :status => 422 }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def url_params
    params.require(:url).permit(:long_url)
  end
end