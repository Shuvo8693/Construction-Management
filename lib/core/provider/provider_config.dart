import 'package:charteur/features/view_models/bottom_nav/bottom_nav_provider.dart';
import 'package:charteur/features/view_models/location/location_provider.dart';
import 'package:charteur/features/view_models/site/site_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class ProviderConfig {

  static List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => BottomNavProvider()),
  ChangeNotifierProvider(create: (_) => LocationProvider()),
  ChangeNotifierProvider(create: (_) => SiteProvider()),
  ];

}