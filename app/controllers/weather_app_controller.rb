class WeatherAppController < ApplicationController

  @data = {}

  def index
   
  end

  def new
    if(params[:search] != nil)
      
      _data_current = WeatherApp.getByCityName(params[:search])
      _data_current = nil if @data_current == false

      _data_future = WeatherApp.futureByCityName(params[:search])
      _data_future = nil if _data_future == false

      @data = {
        "current" => _data_current,
        "future"  => _data_future
      }
    end
  end

end
