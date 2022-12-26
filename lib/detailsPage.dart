import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailsPage extends StatefulWidget {
  var data;

  DetailsPage(this.data, {super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Marker? poMarker;
  LatLng? position;
  var lat;
  var lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat = widget.data['location']['coordinates']['latitude'];
    lng = widget.data['location']['coordinates']['longitude'];
    position = LatLng(double.parse(lat), double.parse(lng));
    poMarker = Marker(markerId: MarkerId("position"), position: position!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            // color: Colors.red,
            child: GoogleMap(
                zoomControlsEnabled: true,
                markers: Set<Marker>.of([poMarker!]),
                initialCameraPosition:
                    CameraPosition(target: position!, zoom: 8.0)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(widget.data['name']['first']),
          Text(widget.data['name']['last']),
          Text(widget.data['location']['street']['name']),
          Text(widget.data['location']['city']),
          Text(widget.data['location']['state']),
          Text("${lat} , ${lng}"),
        ],
      ),
    );
  }
}
