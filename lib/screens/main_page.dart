import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/transactions.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({Key? key, this.index}) : super(key: key);
  static const String id = "main-page";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Transactions(),
    HomePage(),
    HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        child: BottomNavigationBar(
          elevation: 4,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                  Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 1 ? Icons.payment : Icons.payment_outlined),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2
                  ? Icons.account_balance
                  : Icons.account_balance_outlined),
              label: 'Accounts',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3
                  ? Icons.currency_exchange
                  : Icons.currency_exchange),
              label: 'Investments',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black54,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
