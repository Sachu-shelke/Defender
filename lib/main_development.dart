import 'package:flutter/material.dart';
import 'package:defenders/constants/enum.dart';
import 'package:defenders/constants/environments.dart';
import 'package:defenders/main.dart';

void main() {
  mainMirrorHub(MirrorHubEnvironment(EnvironmentType.development));
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
