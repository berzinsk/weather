class WeatherData {
  final int id;
  final String name;
  final int timezone;
  final Coord coord;
  final Weather weather;
  final Main main;
  final SystemData systemData;

  WeatherData({
    required this.id,
    required this.name,
    required this.timezone,
    required this.coord,
    required this.weather,
    required this.main,
    required this.systemData,
  });

  factory WeatherData.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    final timezone = data['timezone'] as int;
    final coordData = data['coord'] as Map<String, dynamic>;
    final coord = Coord.fromJson(coordData);
    final weatherData = data['weather'] as Map<String, dynamic>;
    final weather = Weather.fromJson(weatherData);
    final mainData = data['main'] as Map<String, dynamic>;
    final main = Main.fromJson(mainData);
    final sysData = data['sys'] as Map<String, dynamic>;
    final systemData = SystemData.fromJson(sysData);

    return WeatherData(
      id: id,
      name: name,
      timezone: timezone,
      coord: coord,
      weather: weather,
      main: main,
      systemData: systemData,
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final main = data['main'] as String;
    final description = data['description'] as String;
    final icon = data['icon'] as String;

    return Weather(id: id, main: main, description: description, icon: icon);
  }
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> data) {
    final lat = data['lat'];
    final lon = data['lon'];

    return Coord(lat: lat, lon: lon);
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> data) {
    final temp = data['temp'] as double;
    final feelsLike = data['feels_like'] as double;
    final tempMin = data['temp_min'] as double;
    final tempMax = data['temp_max'] as double;
    final humidity = data['humidity'] as int;

    return Main(
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      humidity: humidity,
    );
  }
}

class SystemData {
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  SystemData({
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SystemData.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final country = data['country'] as String;
    final sunrise = data['sunrise'] as int;
    final sunset = data['sunset'] as int;

    return SystemData(
      id: id,
      country: country,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
