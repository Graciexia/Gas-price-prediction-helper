class CitiesController < ApplicationController

  # before_filter do
  #   redirect_to new_car_path if (current_user.car == nil)
  # end


  def index
    @cities = City.all.order(:name)
    @city_names = @cities.map {|city| city.name}
  end


end
