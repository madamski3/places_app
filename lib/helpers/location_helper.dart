import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBeEUU4H2p2VSUW3K0nVovO9JLzv0NT41I';
const SIGNATURE = 'zL9jbyjw2uhvCkluT2-dtKm1ZCc=';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY');
      final response = await http.get(url);
      final parsedResponse = json.decode(response.body)['results'];
      final responseStatus = json.decode(response.body)['status'];
      print(responseStatus.toString());
      print(parsedResponse.toString());
      return parsedResponse[0]['formatted_address'];
    } catch (error) {
      print(error.toString());
      return 'Unknown address';
    }
  }
}
