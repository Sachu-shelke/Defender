import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CameraReceiverPage extends StatefulWidget {
  final String wsUrl;

  CameraReceiverPage({required this.wsUrl});

  @override
  _CameraReceiverPageState createState() => _CameraReceiverPageState();
}

class _CameraReceiverPageState extends State<CameraReceiverPage> {
  WebSocketChannel? _channel;
  Image? _receivedImage;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    _channel = WebSocketChannel.connect(Uri.parse(widget.wsUrl));
    _isConnected = true;

    _channel!.stream.listen(
          (message) {
        setState(() {
          _receivedImage = Image.memory(base64Decode(message));
        });
      },
      onDone: () {
        setState(() => _isConnected = false);
        _reconnect();
      },
      onError: (error) {
        setState(() => _isConnected = false);
        _reconnect();
      },
    );
  }

  void _reconnect() {
    if (!_isConnected) {
      Future.delayed(Duration(seconds: 2), () {
        _connectWebSocket();
      });
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera Remote")),
      body: Center(
        child: _receivedImage != null
            ? _receivedImage!
            : CircularProgressIndicator(),
      ),
    );
  }
}
