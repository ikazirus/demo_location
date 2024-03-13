import 'dart:io';

import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationService {
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<String> getLocation() async {
    double lat = 0;
    double long = 0;
    String _url = "n/a";
    try {
      _serviceEnabled = await location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return "Service not available : Try again";
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return "No permission given. Please try again";
        }
      }

      location.changeSettings(accuracy: LocationAccuracy.high);

      _locationData = await location.getLocation();
      lat = _locationData.latitude ?? 0;
      long = _locationData.longitude ?? 0;

      // String _url = "https://www.google.com/maps/@$lat,$long,21z";
      _url = "\nhttps://www.google.com/maps/search/$lat,$long";

      if (await canLaunch(_url))
        await launch(
          _url,
        );
      else
        await launch(
          _url,
          enableJavaScript: true,
          forceWebView: true,
        );
    } catch (e) {
      return ('Could not launch $_url.\n Please copy this and paste it in a web browser.\n $e');
    }

    return "\n\nLattitude: $lat\nLongitude: $long\nURL:$_url\n_______________________";
  }
}
