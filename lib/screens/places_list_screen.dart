import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Consumer<Places>(
          child: const Text(
              'You haven\'t added any places yet. Start adding some!'),
          builder: (context, places, ch) => places.items.length <= 0
              ? ch!
              : ListView.builder(
                  itemCount: places.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                        backgroundImage: FileImage(places.items[i].image)),
                    title: Text(places.items[i].title),
                    onTap: () {
                      // TODO - Go to detail page
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
