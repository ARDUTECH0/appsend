import 'package:flutter/material.dart';
import 'package:appsend/A.dart'; // Ensure this import is correct and 'ah' is defined there
import 'package:appsend/Shared/WebSocket.dart'; // Ensure this import is correct and WebSocketService is defined

final WebSocketService webSocketService = WebSocketService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // Replace with your initial widget
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _sendMessage(BuildContext context, final String message) {
    if (message.isNotEmpty) {
      webSocketService.sendMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _sendMessage(context, 'a');
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const ah(),
                        ),
                      );
                    },
                    child: const Text("A"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _sendMessage(context, 's');
                    },
                    child: const Text("s"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _sendMessage(context, 'o');
                    },
                    child: const Text("o"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
