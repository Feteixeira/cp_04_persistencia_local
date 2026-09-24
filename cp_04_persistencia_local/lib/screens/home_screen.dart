import 'package:flutter/material.dart';
import 'list_screen.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<ListScreenState> _listKey = GlobalKey<ListScreenState>();

  void _onItemSaved() {
    _listKey.currentState?.reloadRegistros();
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ListScreen(key: _listKey),
      FormScreen(onSaved: _onItemSaved),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Registros')),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Formulario',
          ),
        ],
      ),
    );
  }
}
