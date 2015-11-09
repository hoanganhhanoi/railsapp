
class WeatherApp 

  def initialize
  end

  def self.getByCityName(name)
    if !name.nil?
      _name_encode = URI::encode(name)
      _data_current = Weather::Newgem.getByName(_name_encode)
      if _data_current != false
        return _data_current
      else
        return false
      end
    end
  end

  def self.futureByCityName(name)
    if !name.nil?
      _name_encode = URI::encode(name)
      _data_future = Weather::Newgem.futureByName(_name_encode)
      if _data_future != false
        return _data_future
      else
        return false
      end
    end
  end

end