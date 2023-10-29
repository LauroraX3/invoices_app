import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoices_app/screens/home_screen/home_screen.dart';
import 'package:invoices_app/screens/invoices_list_screen/invoices_list_screen.dart';
import 'package:invoices_app/style/app_color.dart';

GlobalKey<NavigatorState> invoicesListNavigatorKey =
    GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  Future<bool> _systemBackButtonPressed() async {
    if ((invoicesListNavigatorKey.currentState?.canPop() ?? false)) {
      invoicesListNavigatorKey.currentState
          ?.pop(invoicesListNavigatorKey.currentContext);
    } else {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: _systemBackButtonPressed,
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              HomeScreen(),
              const InvoicesListScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            backgroundColor: AppColor.navy,
            unselectedItemColor: AppColor.lightPink,
            selectedItemColor: AppColor.darkPink,
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
              color: AppColor.lightPink,
              letterSpacing: 1.0,
            ),
            selectedLabelStyle: const TextStyle(
              fontSize: 16,
              color: AppColor.darkPink,
              letterSpacing: 1.0,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
                label: "Strona główna",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 28,
                ),
                label: "Lista faktur",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
