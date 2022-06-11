import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  Function _onSelectPlace;
  LocationInput(this._onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final imageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude!, longitude: locData.longitude!);
    setState(() {
      _previewImageUrl = imageUrl;
    });
    widget._onSelectPlace(locData.latitude, locData.longitude);
    print(locData.latitude);
    print(locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(isSelecting: true),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    widget._onSelectPlace(
        selectedLocation.latitude, selectedLocation.longitude);
    print(selectedLocation.latitude);
    print(selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
            width: 1,
          )),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen yet',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(
                Icons.location_on,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            OutlinedButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(
                Icons.map,
              ),
              label: Text(
                'Select on Map',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
