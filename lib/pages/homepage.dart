import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
  class _HomePageState extends State<HomePage> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.0,
              padding: const EdgeInsets.only(
                  top: 60.0, // Additional top padding
                  left: 16.0, // Uniform padding for left, equivalent to EdgeInsets.all(16.0)
                  right: 16.0, // Uniform padding for right, equivalent to EdgeInsets.all(16.0)
                  bottom: 16.0, // Uniform padding for bottom, equivalent to EdgeInsets.all(16.0)
                ),
              color: const Color.fromARGB(255, 207, 241, 255),
              child: const Text('Good Afternoon!'),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text('Content Section 1'),
                    SizedBox(height: 20.0), // Adds space between sections
                    Text('Content Section 2'),
                    Divider(), // Visually separates sections
                    Text('Content Section 3'),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blue,
              child: const Text('Footer Section'),
            ),
          ],
          ),
      );
    }
  }