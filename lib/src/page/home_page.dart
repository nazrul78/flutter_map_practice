import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_practice/src/base/base.dart';
import 'package:latlong2/latlong.dart';

typedef PolylineHitNotifier = ValueNotifier<Polyline?>;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PolylineHitNotifier hitNotifier = ValueNotifier(null);

  //   List<HitValue>? _prevHitValues;
  // List<Polyline<HitValue>>? _hoverLines;

  final _polylinesRaw = <Polyline>[
    Polyline(
      points: const [
        LatLng(40, 150),
        LatLng(45, 160),
        LatLng(50, 170),
        LatLng(55, 180),
        LatLng(50, -170),
        LatLng(45, -160),
        LatLng(40, -150),
      ],
      strokeWidth: 8,
      color: const Color(0xFFFF0000),
      // hitValue: (
      //   title: 'Red Line',
      //   subtitle: 'Across the universe...',
      // ),
    ),
    Polyline(
      points: [
        const LatLng(51.5, -0.09),
        const LatLng(53.3498, -6.2603),
        const LatLng(48.8566, 2.3522),
      ],
      strokeWidth: 8,
      color: const Color(0xFF60399E),
      // hitValue: (
      //   title: 'Purple Line',
      //   subtitle: 'Nothing really special here...',
      // ),
    ),
    Polyline(
      points: [
        const LatLng(48.5, -3.09),
        const LatLng(47.3498, -9.2603),
        const LatLng(43.8566, -1.3522),
      ],
      strokeWidth: 16000,
      color: Colors.pink,
      useStrokeWidthInMeter: true,
      // hitValue: (
      //   title: 'Pink Line',
      //   subtitle: 'Fixed radius in meters instead of pixels',
      // ),
    ),
    Polyline(
      points: [
        const LatLng(51.74904, -10.32324),
        const LatLng(54.3498, -6.2603),
        const LatLng(52.8566, 2.3522),
      ],
      strokeWidth: 4,
      gradientColors: [
        const Color(0xffE40203),
        const Color(0xffFEED00),
        const Color(0xff007E2D),
      ],
      // hitValue: (
      //   title: 'Traffic Light Line',
      //   subtitle: 'Fancy gradient instead of a solid color',
      // ),
    ),
    Polyline(
      points: const [
        LatLng(50.5, -0.09),
        LatLng(51.3498, 6.2603),
        LatLng(53.8566, 2.3522),
      ],
      strokeWidth: 20,
      color: Colors.blue.withAlpha(153),
      borderStrokeWidth: 20,
      borderColor: Colors.red.withAlpha(102),
      // hitValue: (
      //   title: 'Bordered Line',
      //   subtitle: 'Solid translucent color fill, with different color outline',
      // ),
    ),
    Polyline(
      points: const [
        LatLng(49.1, -0.06),
        LatLng(52.15, -1.4),
        LatLng(55.5, 0.8),
      ],
      strokeWidth: 10,
      color: Colors.yellow,
      borderStrokeWidth: 10,
      borderColor: Colors.blue.withAlpha(128),
      // hitValue: (
      //   title: 'BorderedLine 2',
      //   subtitle: 'Solid translucent color fill, with different color outline',
      // ),
    ),
    Polyline(
      points: const [
        LatLng(43.864797, 11.7112939),
        LatLng(36.7948545, 10.2256785),
        LatLng(35.566530, 5.584283),
      ],
      strokeWidth: 10,
      color: Colors.orange,
      pattern: const StrokePattern.dotted(
        spacingFactor: 3,
      ),
      borderStrokeWidth: 8,
      borderColor: Colors.blue.withAlpha(128),
      // hitValue: (
      //   title: 'Orange line',
      //   subtitle: 'Dotted pattern',
      // ),
    ),
    // Paris-Nice TGV
    Polyline(
      points: const [
        // Paris
        LatLng(48.8567, 2.3519),
        // Lyon
        LatLng(45.7256, 5.0811),
        // Avignon
        LatLng(43.95, 4.8169),
        // Aix-en-Provence
        LatLng(43.5311, 5.4539),
        // Marseille
        LatLng(43.2964, 5.37),
        // Toulon
        LatLng(43.1222, 5.93),
        // Cannes
        LatLng(43.5514, 7.0128),
        // Antibes
        LatLng(43.5808, 7.1239),
        // Nice
        LatLng(43.6958, 7.2714),
      ],
      strokeWidth: 6,
      color: Colors.green[900]!,
      pattern: StrokePattern.dashed(
        segments: const [50, 20, 30, 20],
      ),
      borderStrokeWidth: 6,
      hitValue: (
        title: 'Green Line',
        subtitle: 'Dashed line',
      ),
    ),
  ];
  late final _polylines =
      Map.fromEntries(_polylinesRaw.map((e) => MapEntry(e.hitValue, e)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Stack(
        children: [
          FlutterMap(
            mapController: Base.homePageController.kMapController,
            options: MapOptions(
              initialCenter: LatLng(22, 90),
              //  Base.homePageController.centerLatlng.value ?? LatLng(22, 90),
              initialZoom: 10,
              onTap: (tapPosition, point) {
                log('$point');
              },
            ),
            children: [
              TileLayer(
                ///======>> OSM Map=========
                // urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

                ///======>> SAT Map=========
                // urlTemplate:
                //     'http://www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',

                ///======>> Google Map=========
                urlTemplate:
                    'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
                // userAgentPackageName: 'com.example.app',
              ),

              MouseRegion(
                hitTestBehavior: HitTestBehavior.deferToChild,
                cursor: SystemMouseCursors.click,
                // onHover: (_) {
                //   if (hitNotifier.value == null) return;

                //   final lines = hitNotifier.value!.lines
                //       .where((e) => polylines.containsKey(e))
                //       .map(
                //         (e) => Polyline(
                //           points: e.points,
                //           strokeWidth: e.strokeWidth + e.borderStrokeWidth,
                //           color: Colors.transparent,
                //           borderStrokeWidth: 15,
                //           borderColor: Colors.green,
                //           useStrokeWidthInMeter: e.useStrokeWidthInMeter,
                //         ),
                //       )
                //       .toList();
                //   setState(() => hoverLines = lines);
                // },

                /// Clear hovered lines when touched lines modal appears
                // onExit: (_) => setState(() => hoverLines = null),
                child: GestureDetector(
                  // onTap: () => _openTouchedLinesModal(
                  //   'Tapped',
                  //   hitNotifier.value!.lines,
                  //   hitNotifier.value!.point,
                  // ),
                  onTap: () {
                    log('Tapped');
                    log('${hitNotifier.value!}');
                    log('${hitNotifier.value!}');
                    log('${hitNotifier.value!}');
                    log('${hitNotifier.value!}');
                    log('${hitNotifier.value!}');
                  },
                  // onLongPress: () => _openTouchedLinesModal(
                  //   'Long pressed',
                  //   hitNotifier.value!.lines,
                  //   hitNotifier.value!.point,
                  // ),
                  // onSecondaryTap: () => _openTouchedLinesModal(
                  //   'Secondary tapped',
                  //   hitNotifier.value!.lines,
                  //   hitNotifier.value!.point,
                  // ),
                  // child: PolylineLayer(
                  //   // hitNotifier: hitNotifier,
                  //   // polylines:
                  //   //     polylines.keys.followedBy(hoverLines ?? []).toList(),
                  // ),
                ),
              ),

              // MarkerLayer(
              //   // markers: Base.homePageController.siteInfoMarkers,

              //   markers: [
              //     Marker(
              //       point: LatLng(23.809957, 90.4037839),
              //       width: 60,
              //       height: 60,
              //       // child: FlutterLogo(),
              //       child: GestureDetector(
              //           onTap: () {
              //             // DialogHelper.showActionTypeSelectionDialog(
              //             //   title: 'Select an action type',
              //             //   buttonText1: 'Edit',
              //             //   buttonText2: 'Drag',
              //             //   onPressed1: () {
              //             //     Get.back();

              //             //     log('Marker pressed>>>>>>>>>>>>>>>>>');

              //             //     //  DialogHelper.showRotationDialog(item.id!);
              //             //   },
              //             //   onPressed2: () {
              //             //     Get.back();
              //             //   },
              //             // );
              //           },
              //           child: Icon(Icons.location_pin, size: 60)),
              //     ),
              //     Marker(
              //       point: LatLng(22.787467, 89.921511),
              //       width: 60,
              //       height: 60,
              //       // child: FlutterLogo(),
              //       child: Icon(Icons.location_pin, size: 60),
              //     ),
              //   ],
              // ),

              // if (Base.homePageController.isCurrentLocationEnable.value)
              //   CircleLayer(
              //     circles: [
              //       CircleMarker(
              //         point: Base.locationController.currentLoc.value!,
              //         radius: 9,
              //         useRadiusInMeter: false,
              //         color: Colors.blue,
              //         borderStrokeWidth: 3,
              //         borderColor: Colors.white,
              //       ),
              //     ],
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
