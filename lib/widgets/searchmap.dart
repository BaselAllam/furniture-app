import 'package:cls/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SearchMap extends StatefulWidget {
  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {

Position position;

final TextEditingController searchMapController = TextEditingController();

bool loading = false;

List<Marker> markers = [];

@override
void initState() {
  searchLocation();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Delivery Location',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        bottom: PreferredSize(
          child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.black, width: 0.5)
                ),
                  disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.grey, width: 0.5)
                ),
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.black, width: 0.5)
                ),
                  errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.red, width: 0.5)
                ),
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.black, width: 0.5)
                ),
                  focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: Colors.red, width: 0.5)
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black, size: 20.0),
                labelText: 'ex; cairo',
                labelStyle: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: searchMapController,
              onSubmitted: (value){
                searchLocation();
              },
            ),
            preferredSize: Size(0.0, 40.0),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: loading == true ? Center(child: Loading()) : buildMap(),
    );
  }
  searchLocation() async {

    setState(() {
      loading = true;
    });

    var locationService = await Geolocator().isLocationServiceEnabled();

    if(locationService == false){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return dialog('location services not enabled, kindly enable it!');
        }
      );
      setState(() {
        loading = false;
      });
    }else if(searchMapController.text.isEmpty){
      var _currentLocation = await Geolocator().getCurrentPosition();
      setState(() {
        position = _currentLocation;
        loading = false;
      });
    }else{
      List<Placemark> _searchedLocations = await Geolocator().placemarkFromAddress(searchMapController.text);
      final Marker _marker = Marker(
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(_searchedLocations[0].position.latitude, _searchedLocations[0].position.longitude),
        visible: true,
        infoWindow: InfoWindow(title: _searchedLocations[0].name),
        markerId: MarkerId('Your Location')
      );
      markers.add(_marker);
      setState(() {
        position = _searchedLocations[0].position;
        loading = false;
      });
    }
  }
  dialog(String content) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text(
        'Note!',
        style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)
      ),
      content: Text(
        content,
        style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.normal)
      ),
      actions: [
        FlatButton(
          child: Text(
            'cancel',
            style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.normal)
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.grey,
          onPressed: () {}
        ),
        FlatButton(
          child: Text(
            'ok',
            style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.normal)
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.black,
          onPressed: () {}
        ),
      ],
    );
  }
  buildMap() {
    return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 12
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: Set.from(markers),
      );
  }
}



// 1- check location services if enabled 
    // a- not enabled => show dialog please enable location services 
    // b- enabled => 
        // a- not searched about an adrees
        // b- get current location