class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_filter :has_permission, :only => [:edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.user = current_user

    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "Restaurant deleted successfully"
    redirect_to restaurants_path
  end

  def has_permission
    if current_user != Restaurant.find(params[:id]).user
      redirect_to root_path, alert: 'You are not authorised to carry out that action on this restaurant'
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image)
  end

end
