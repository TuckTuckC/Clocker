import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clocker/providers/timeState.dart';
import 'package:clocker/pages/homepage.dart';
import 'package:clocker/pages/timeclock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
Widget build(BuildContext context) {
    // Wrap the MaterialApp with ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => TimeClockedIn(), // Here we instantiate the state provider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        home: const MainScreen(), // MainScreen now has access to the TimeClockedIn state
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    const HomePage(),   // Assuming HomePage is a separate widget
    const TimeClock(),  // Assuming TimeClock is a separate widget  // You need to create this page
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.punch_clock),
            label: 'Time Clock',
            backgroundColor: Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.other_houses),
            label: 'Other',
            backgroundColor: Color.fromARGB(255, 66, 5, 126),
          ),
        ],
        onTap: _onTap,
      ),
    );
  }
}
