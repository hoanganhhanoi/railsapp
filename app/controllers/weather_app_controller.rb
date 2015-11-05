class WeatherAppController < ApplicationController

  def index
   
  end

  def new
    if(params[:search] != nil)
      @data = WeatherApp.getByCityName(params[:search])
      p @data
    end
  end

end
