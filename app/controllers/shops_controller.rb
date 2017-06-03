class ShopsController < ApplicationController
  before_filter :check_gps_activation, only: [:create]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    begin
      @shop.save!
      flash[:notice] = "Your shop is registered successfully"
      redirect_to shop_path(@shop)
    rescue Exception => e
      flash[:error] = e.message
      render action: :new
    end
  end

  def show
    begin
      @shop = Shop.find(params[:id])
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :back
    end
  end

  private
  def enable_gps?
    (EXIFR::JPEG.new(params[:shop][:photo].path).gps.present? rescue nil)
  end

  def check_gps_activation
    if params[:location_by_photo].present? && !enable_gps?
      flash[:error] = "Invalid photo! Does not have GPS information."
      redirect_to :back
    end
  end

  def shop_params
    req_params = params.require(:shop).permit(:name, :address, :description, :photo, :latitude, :longitude)
    if enable_gps?
      img = EXIFR::JPEG.new(params[:shop][:photo].path)
      req_params[:latitude] = img.gps.latitude
      req_params[:longitude] = img.gps.longitude
      req_params[:address] = Geocoder::address req_params.slice(:latitude, :longitude).values.join(', ')
    end
    req_params
  end
end
