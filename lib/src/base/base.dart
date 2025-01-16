import 'package:flutter_map_practice/src/controllers/config_controller.dart';
import 'package:flutter_map_practice/src/controllers/home_page_controller.dart';
import 'package:flutter_map_practice/src/controllers/location_controller.dart';

class Base {
  Base._();
  static final configController = ConfigController();
  static final himeController = HomePageController();
  static final locationController = LocationController();
}
