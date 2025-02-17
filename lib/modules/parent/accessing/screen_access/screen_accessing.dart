import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScreenAudioReceiver extends StatefulWidget {
  @override
  _ScreenAudioReceiverState createState() => _ScreenAudioReceiverState();
}

class _ScreenAudioReceiverState extends State<ScreenAudioReceiver> {
  MediaStream? _remoteStream;
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    _setupStream();
  }

  void _setupStream() {
    socket = IO.io("https://your-server.com", <String, dynamic>{
      "transports": ["websocket"],
    });

    socket!.on("broadcast", (data) {
      setState(() {
        _remoteStream = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Screen + Audio Monitor")),
      body: Center(
        child: _remoteStream == null
            ? CircularProgressIndicator()
            : RTCVideoView(RTCVideoRenderer()..srcObject = _remoteStream),
      ),
    );
  }

  @override
  void dispose() {
    socket?.disconnect();
    _remoteStream?.dispose();
    super.dispose();
  }
}
