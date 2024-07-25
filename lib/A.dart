import 'package:appsend/main.dart';
import 'package:flutter/material.dart';

class ah extends StatefulWidget {
  const ah({super.key});

  @override
  State<ah> createState() => _ahState();
}

class _ahState extends State<ah> {
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
                      Navigator.pop(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text("back"),
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
