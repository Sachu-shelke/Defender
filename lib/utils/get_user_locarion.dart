// ignore_for_file: use_build_context_synchronously

// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class UserLocation {
  Circle circle = Circle();
  Future<String> getCurrentPosition(
      Function()? afterSuccess, BuildContext? context, int index,
      {bool? dontDo}) async {
    if (context != null) circle.show(context);
    loc.Location location = loc.Location();
    bool ison = await location.serviceEnabled();
    if (!ison) {
      bool isturnedon = await location.requestService();
      if (!isturnedon) {
        if (context != null) circle.hide(context);
        return "PERMISSION";
      }
    }

    if (GlobalSingleton.currentPosition != null) {
      if (context != null) circle.hide(context);
      return "SUCCESS";
    }
    final bool hasPermission =
        await handleLocationPermission(afterSuccess, dontDo: dontDo);

    if (!hasPermission) {
      if (context != null) circle.hide(context);
      return "FAILED";
    }

    try {
      final LocationPermission hasPermission =
          await Geolocator.checkPermission();
      if (hasPermission.name != "denied") {
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        GlobalSingleton.currentPosition = position;
        if (context != null) circle.hide(context);
        return "SUCCESS";
      } else {
        return "FAILED";
      }

      // return _getAddressFromLatLng(position);
    } on Position catch (_) {
      if (context != null) circle.hide(context);
      return "FAILED";
    }
  }

  Future<bool> handleLocationPermission(Function()? afterSuccess,
      {bool? dontDo}) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && dontDo != true) {
        // appRouter
        //     .push(LocationPermissionScreenRoute(afterSuccess: afterSuccess));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever && dontDo != true) {
      // appRouter.push(LocationPermissionScreenRoute(afterSuccess: afterSuccess));
      return false;
    }

    return true;
  }
}

class UserContact {
  Circle circle = Circle();
  Future<String> getLatestContact(
      Function()? afterSuccess, BuildContext? context, int index,
      {bool? dontDo}) async {
    if (context != null) circle.show(context);
    PermissionStatus permission = await Permission.contacts.status;

    if (!permission.isGranted) {
      await Permission.contacts.request();
    }

    // if (GlobalSingleton.contact.isNotEmpty) {
      if (context != null) circle.hide(context);
      return "SUCCESS";
    }
    // final bool hasPermission =
    //     await handleLocationPermission(afterSuccess, dontDo: dontDo);
    //
    // if (!hasPermission) {
    //   if (context != null) circle.hide(context);
    //   return "FAILED";
    // }
    //
    // try {
    //   final PermissionStatus permission = await Permission.contacts.status;
    //   if (permission == PermissionStatus.granted) {
    //     List<Contact> getContact = await ContactsService.getContacts();
    //     GlobalSingleton.contact = getContact;
    //     if (context != null) circle.hide(context);
    //     return "SUCCESS";
    //   } else {
    //     return "FAILED";
    //   }
    // } on Position catch (_) {
    //   if (context != null) circle.hide(context);
    //   return "FAILED";
    // }
  }

  Future<bool> handleLocationPermission(Function()? afterSuccess,
      {bool? dontDo}) async {
    PermissionStatus permission = await Permission.contacts.status;

    if (permission == PermissionStatus.denied) {
      permission = await Permission.contacts.request();
      if (permission == PermissionStatus.denied && dontDo != true) {
        // appRouter
        //     .push(LocationPermissionScreenRoute(afterSuccess: afterSuccess));
        return false;
      }
    }
    if (permission == PermissionStatus.permanentlyDenied && dontDo != true) {
      // appRouter.push(LocationPermissionScreenRoute(afterSuccess: afterSuccess));
      return false;
    }

    return true;
  }
// }
