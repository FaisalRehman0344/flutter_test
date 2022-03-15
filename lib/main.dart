import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:steps_counter/screens/collect_screen.dart';
import 'package:steps_counter/widgets/collect_screen/action_button.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Steps Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CollectScreen(),
    CollectScreen(),
    CollectScreen(),
    CollectScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          actionButton(
            icon: Icon(Icons.shopping_cart_outlined),
            count: "0",
          ),
          actionButton(
            icon: Icon(Icons.mail_outline),
            count: "0",
          ),
          actionButton(
            icon: Icon(Icons.notifications_outlined),
            count: "0",
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: const IconThemeData(color: Colors.white),
        selectedIconTheme: const IconThemeData(color: Colors.white),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.coins),
            label: 'Collect',
            backgroundColor: Colors.grey.shade700.withOpacity(.5),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.medal),
            label: 'Leaderboard',
            backgroundColor: Colors.grey.shade700.withOpacity(.5),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.battleNet),
            label: 'Challenge',
            backgroundColor: Colors.grey.shade700.withOpacity(.5),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(Icons.shopping_cart_checkout_outlined),
            label: 'Store',
            backgroundColor: Colors.grey.shade700.withOpacity(.5),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
