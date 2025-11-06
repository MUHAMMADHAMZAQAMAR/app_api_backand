// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPos;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  void _loadLocation() async {
    final pos = await LocationService.getCurrentLocation();
    if (pos != null) {
      setState(() => _currentPos = LatLng(pos.latitude, pos.longitude));
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPos!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        myLocationEnabled: true,
        onMapCreated: (controller) => _mapController = controller,
        markers: _currentPos != null
            ? {
          Marker(
            markerId: const MarkerId('current'),
            position: _currentPos!,
          )
        }
            : {},
      ),
    );
  }
}