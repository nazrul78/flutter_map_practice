import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

typedef HitValue = ({String title, String subtitle});

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final kMapController = MapController();
  // Create a LayerHitNotifier to track the hit value when a polyline is tapped
  final LayerHitNotifier<HitValue> _hitNotifier = ValueNotifier(null);

  // Create a list of polylines
  final List<Polyline<HitValue>> _polylines = [
    Polyline(
      points: const [
        LatLng(51.5, -0.09),
        LatLng(53.3498, -6.2603),
        LatLng(48.8566, 2.3522),
      ],
      strokeWidth: 8,
      color: Colors.red,
      hitValue: (
        title: 'Red Line',
        subtitle: 'This is the red line! Nazrul',
      ),
    ),
    Polyline(
      points: const [
        LatLng(40.0, -3.0),
        LatLng(45.0, 0.0),
        LatLng(50.0, 3.0),
      ],
      strokeWidth: 8,
      color: Colors.blue,
      hitValue: (
        title: 'Blue Line',
        subtitle: 'This is the blue line! Monir',
      ),
    ),
  ];

  void _handleTap() {
    // Check if any polyline was hit
    if (_hitNotifier.value == null || _hitNotifier.value!.hitValues.isEmpty) {
      print("No polyline hit detected.");
      return;
    }

    // If polyline was hit, show details
    final tappedLines = _hitNotifier.value!.hitValues;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Polyline Tapped!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: tappedLines
              .map((line) => ListTile(
                    title: Text(line.title),
                    subtitle: Text(line.subtitle),
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Polyline Tap Detection')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(51.5, -0.09),
          initialZoom: 5,
          onTap: (p, l) {
            // Triggered on tap to check for polyline hit
            _handleTap();
          },
        ),
        children: [
          TileLayer(
            ///======>> Google Map=========
            urlTemplate: 'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
            subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
          ),
          PolylineLayer(
            hitNotifier:
                _hitNotifier, // Add the hit notifier to track polyline taps
            polylines: _polylines,
          ),
        ],
      ),
    );
  }
}
