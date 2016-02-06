class ShopsController < ApplicationController
  def index
  end

  def new
    @shop = Shop.new
  end

  def search_map
    address = params[:search_map][:address]
    @latitude, @longitude = Geocoder.coordinates address
  end
end
