import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ConnectionStatus {
  connecting,
  connected,
  disconnected,
}

class WebSocketService {
  WebSocketChannel? _channel;
  ConnectionStatus _currentStatus = ConnectionStatus.disconnected;
  final _messageController = StreamController<dynamic>.broadcast();
  final _connectionStatusController =
      StreamController<ConnectionStatus>.broadcast();

  Stream<dynamic> get incomingMessages => _messageController.stream;
  Stream<ConnectionStatus> get connectionStatus =>
      _connectionStatusController.stream;

  WebSocketService() {
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    _updateConnectionStatus(ConnectionStatus.connecting);

    try {
      if (kIsWeb) {
        final wsUrl = Uri.parse('ws://192.168.4.1:80/ws');
        _channel = WebSocketChannel.connect(wsUrl);
      } else {
        _channel = IOWebSocketChannel.connect('ws://192.168.4.1:80/ws');
      }

      _updateConnectionStatus(ConnectionStatus.connected);
    } catch (e) {
      print("WebSocket initialization error: $e");
      _updateConnectionStatus(ConnectionStatus.disconnected);
    }

    // Handle WebSocket errors
    _channel?.sink.done.then((_) {
      print("WebSocket connection closed.");
      _initializeWebSocket();

      _updateConnectionStatus(ConnectionStatus.disconnected);
    }).catchError((error) {
      print("WebSocket error: $error");
      _updateConnectionStatus(ConnectionStatus.disconnected);
    });

    _channel!.stream.listen(
      (message) {
        print("Received message from WebSocket: $message");
        // print(status1);
        _messageController.add(message);
      },
    );
  }

  void _updateConnectionStatus(ConnectionStatus status) {
    _currentStatus = status;
    _connectionStatusController.add(status);
  }

  String status1(String status) {
    status = "_currentStatus";
    return status;
  }

  void sendMessage(String message) {
    if (_channel != null && _channel!.sink != null) {
      _channel!.sink.add(message);
    }
  }

  void sendJsonData(Map<String, dynamic> jsonData) {
    final jsonString = jsonEncode(jsonData);
    if (_channel != null && _channel!.sink != null) {
      _channel!.sink.add(jsonString);
    }
  }

  void dispose() {
    if (_channel != null && _channel!.sink != null) {
      _channel!.sink.close();
    }
    _messageController.close();
    _connectionStatusController.close();
  }

  void someMethod() {}
}
