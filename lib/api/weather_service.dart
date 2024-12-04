import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey =
      '0c0a90d4186ebe02dac0a378fce7899c'; // Ganti dengan API key kamu

  Future<Map<String, dynamic>> getWeather() async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'q': 'Tegal', // Kota Jakarta
          'appid': apiKey, // API Key
          'units': 'metric', // Untuk suhu dalam Celsius
        },
      );

      if (response.statusCode == 200) {
        // Ambil data yang diperlukan
        return {
          'temp': response.data['main']['temp'], // Suhu
          'city': response.data['name'], // Nama kota
          'country': response.data['sys']['country'], // Nama negara
          'description': response.data['weather'][0]
              ['description'], // Deskripsi cuaca
        };
      } else {
        return {};
      }
    } catch (e) {
      print("Error: $e");
      return {};
    }
  }
}
