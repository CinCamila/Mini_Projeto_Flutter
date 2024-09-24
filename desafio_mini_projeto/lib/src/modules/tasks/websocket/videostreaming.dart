import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:desafio_mini_projeto/src/modules/tasks/websocket/websocket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({super.key});

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  final StreamWebSocket streamSocket = StreamWebSocket();
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    connectAndListen();
  }

  void connectAndListen() {
    _channel =
        WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:8000/ws/camera'));
    _channel.stream.listen((message) {
      print("Received message: $message");
      streamSocket.addResponse(message);
    }, onError: (error) {
      print("Error: $error");
    }, onDone: () {
      print("WebSocket connection closed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Stream')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: streamSocket.getResponse,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final imageBytes = base64.decode(snapshot.data!);
                final image = Image.memory(
                  imageBytes,
                  fit: BoxFit.scaleDown,
                  gaplessPlayback: true,
                );
                return image;
              } else if (snapshot.hasError) {
                return Text('Erro: & ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
