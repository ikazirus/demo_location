import 'package:demo_location/location_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String cords = "";
  LocationService _service = LocationService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: SelectableText('Locations \n\n$cords'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            cords += (await _service.getLocation() + "\n");
            setState(() {});
          },
          child: Icon(Icons.location_on),
        ),
      ),
    );
  }
}
