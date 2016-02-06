class ShopsController < ApplicationController
  def index
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    begin
      @shop.save!
      flash[:notice] = "Your shop is registered successfully"
      redirect_to new_shop_path
    rescue Exception => e
      render action: :new
      flash[:error] = e.message
    end

  end

  def search_map
    address = params[:search_map][:address]
    @latitude, @longitude = Geocoder.coordinates address
  end

  private
  def shop_params
    params.require(:shop).permit(:name, :address, :description, :photo, :latitude, :longitude)
  end
end
