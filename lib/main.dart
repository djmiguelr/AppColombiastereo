/*
 *  main.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/services/admob_service.dart';
import 'package:single_radio/services/fcm_service.dart';
import 'package:single_radio/screens/player/player_view.dart';
import 'package:single_radio/screens/player/player_viewmodel.dart';
import 'package:single_radio/screens/timer/timer_view.dart';
import 'package:single_radio/screens/timer/timer_viewmodel.dart';
import 'package:single_radio/screens/about/about_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set device orientation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Init services.
  await AdmobService.init();
  await FcmService.init();

  // Init view models.
  late final playerViewModel = PlayerViewModel();
  late final timerViewModel = TimerViewModel(onTimer: playerViewModel.pause);

  // Init providers.
  final providers = [
    ChangeNotifierProvider<PlayerViewModel>.value(value: playerViewModel),
    ChangeNotifierProvider<TimerViewModel>.value(value: timerViewModel),
  ];

  // Init routes.
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PlayerView.routeName:
        return MaterialPageRoute(
          builder: (context) => const PlayerView(),
        );
      case AboutView.routeName:
        return MaterialPageRoute(
          builder: (context) => const AboutView(),
        );
      case TimerView.routeName:
        return MaterialPageRoute(
          builder: (context) => const TimerView(),
          allowSnapshotting: false,
        );
      default:
        return null;
    }
  }

  runApp(App(
    providers: providers,
    onGenerateRoute: onGenerateRoute,
  ));
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.providers,
    required this.onGenerateRoute,
  });

  final List<SingleChildStatelessWidget> providers;
  final Route<dynamic>? Function(RouteSettings) onGenerateRoute;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Config.title,
        theme: AppTheme.themeData,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
