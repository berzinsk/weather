import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/resources/constants/app_constants.dart';

class StorageService {
  Future<void> setLocationStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(storageLocationEnabled, status);
  }

  Future<bool> getLocationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final locationEnabled = prefs.getBool(storageLocationEnabled) ?? false;

    return locationEnabled;
  }

  Future<void> addCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    var storedCities = prefs.getStringList(storageCities) ?? List.empty();
    final cities = [...storedCities, city];

    await prefs.setStringList(storageCities, cities);
  }

  Future<List<String>> getCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(storageCities) ?? List.empty();
  }
}
