import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'custom_dailog.dart';

showPermission({required context, title}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDailog(
          title: 'Permission',
          subtitle: 'App need $title permission to proceed',
          onPress: () async {
            Navigator.pop(context);
            await Geolocator.openAppSettings();
          },
          buttonText: 'Grant Permission',
          isIcon: false);
    },
  );
}
