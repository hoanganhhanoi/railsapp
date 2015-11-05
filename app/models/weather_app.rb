
class WeatherApp 

  def initialize
  end

  def self.getByCityName(name)
    if !name.nil?
      name_encode = URI::encode(name)
      p name_encode
      @data_current = Weather::Newgem.getByName(name_encode)
    end
  end

end