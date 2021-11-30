class CountriesController < ApplicationController
  def fetch_cities
    @cities = City.country_id(params[:country_id])
    render partial: 'cities', object: @cities, layout: false
  end
end