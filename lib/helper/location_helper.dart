import 'package:url_launcher/url_launcher.dart';

const Map_API_KEY =
    'pk.eyJ1IjoiYWJkZWxyaG1hbnNhbGVoIiwiYSI6ImNrMnYxMnFtdDAwOWkzZXBncTZqbGw1eWkifQ.EMdxYrba9j8f0416c7Dypw';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    print(latitude);
    print(longitude);
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,9.67,0.00,0.00/600x300@2x?access_token=$Map_API_KEY';
  }

  static openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
