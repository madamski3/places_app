import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/map_screen.dart';
import '../providers/places.dart';
import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments.toString();
    print(id);
    final place = Provider.of<Places>(context).findById(id);

    void _deletePlace(String id) {
      Navigator.of(context).pop();
      Provider.of<Places>(context, listen: false).deletePlace(place.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        actions: [
          IconButton(
            onPressed: () => _deletePlace(place.id),
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            place.location!.address as String,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      initialLocation: place.location!,
                      isSelecting: false,
                    ),
                  ),
                );
              },
              child: Text(
                'View on map',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
    );
  }
}
