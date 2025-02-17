import 'package:flutter/material.dart';
import 'package:defenders/constants/enum.dart';

import 'constants/environments.dart';
import 'main.dart';

void main() {
  mainMirrorHub(MirrorHubEnvironment(EnvironmentType.production));
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}
