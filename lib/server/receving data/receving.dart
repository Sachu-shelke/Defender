import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:usage_stats/usage_stats.dart';

const String serverUrl = 'https://yourserver.com';

// Get device ID (Android specific)
Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.id;
}

// Get app usage stats from the server
Future<void> getAppUsageFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/app_usage', data);
}

// Get call details from the server
Future<void> getCallDetailsFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/call_details', data);
}

// Get audio data from the server
Future<void> getAudioDataFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/audio_data', data);
}

// Get camera data from the server
Future<void> getCameraDataFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/camera_data', data);
}

// Get SMS data from the server
Future<void> getSmsDataFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/sms_data', data);
}

// Get location data from the server
Future<void> getLocationFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/location', data);
}

// Get screen state (app state) from the server
Future<void> getScreenStateFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/screen_monitoring', data);
}

// Get installed apps data from the server
Future<void> getInstalledAppsFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/installed_apps', data);
}

// Get notification data from the server
Future<void> getNotificationFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/notification', data);
}

// Get binding code from the server
Future<void> getBindingCodeFromServer() async {
  String deviceId = await getDeviceId();
  var data = {
    "device_id": deviceId,
  };
  await _getRequest('/send_binding_code', data);
}

// Receive data from the server using GET request
Future<void> _getRequest(String endpoint, Map<String, dynamic> data) async {
  try {
    var uri = Uri.parse('$serverUrl$endpoint').replace(queryParameters: data);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      // Handle successful response
      var responseData = jsonDecode(response.body);
      print("Received data: $responseData");

      // You can now parse the data depending on the structure
    } else {
      print("Failed to receive data from $endpoint: ${response.statusCode}");
    }
  } catch (e) {
    print("Error receiving data from $endpoint: $e");
  }
}

// Receive a file from the server using GET request
Future<void> getFileFromServer(String endpoint) async {
  try {
    var response = await http.get(Uri.parse('$serverUrl$endpoint'));

    if (response.statusCode == 200) {
      Uint8List fileData = response.bodyBytes;
      print("File received successfully");
      // You can save or use the file data here
    } else {
      print("Failed to receive file from $endpoint: ${response.statusCode}");
    }
  } catch (e) {
    print("Error receiving file from $endpoint: $e");
  }
}
