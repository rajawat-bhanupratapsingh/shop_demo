class ShopsController < ApplicationController
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
      render action: :new
      flash[:error] = e.message
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
  def shop_params
    params.require(:shop).permit(:name, :address, :description, :photo, :latitude, :longitude)
  end
end
