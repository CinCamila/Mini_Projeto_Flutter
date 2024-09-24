import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({super.key});

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  late WebSocketChannel _channel;
  bool _isConnected = false;
  Uint8List? _imageBytes;

  void connect() {
    try {
      _channel =
          WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:8000/ws/camera'));
      setState(() {
        _isConnected = true;
      });

      _channel.stream.listen((data) {
        setState(() {
          _imageBytes = base64Decode(data);
        });
      }, onDone: () {
        setState(() {
          _isConnected = false;
        });
      });
    } catch (e) {
      print('Connection error: $e');
    }
  }

  void disconnect() {
    if (_isConnected) {
      _channel.sink.close();
      setState(() {
        _isConnected = false;
        _imageBytes = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Video Stream")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: connect,
              child: const Text("Connect"),
            ),
            ElevatedButton(
              onPressed: disconnect,
              child: const Text("Disconnect"),
            ),
            Text(_isConnected ? "Connected" : "Disconnected"),
            _imageBytes != null
                ? Image.memory(
                    _imageBytes!,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  )
                : const Text("No image available"),
          ],
        ),
      ),
    );
  }
}
