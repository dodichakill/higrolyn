import 'package:dio/dio.dart';

class VideoService {
  final Dio _dio = Dio();

  Future<List> getVideo() async {
    try {
      final response = await _dio.get(
          'https://www.googleapis.com/youtube/v3/search',
          queryParameters: {
            'part': 'snippet',
            'q': 'pertanian', // Kata kunci untuk pencarian video
            'type': 'video',
            'regionCode': 'ID', // Negara Indonesia
            'maxResults': 10, // Jumlah hasil yang ingin ditampilkan
            'key':
                'AIzaSyDkSw6rLoSiVq4IE7m3ZRPW5K69lRqHmU4' // Ganti dengan API key Anda
          });
      if (response.data['items'] != null) {
        return response.data['items']; // Mengembalikan daftar video
      } else {
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
