const GOOGLE_API_KEY = 'AIzaSyC3suCUDwsXWo7f7o3B-vnmejbWYpt7siU';
const SIGNATURE = 'zL9jbyjw2uhvCkluT2-dtKm1ZCc=';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
