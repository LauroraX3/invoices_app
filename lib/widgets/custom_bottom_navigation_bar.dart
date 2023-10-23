import 'package:flutter/material.dart';
import 'package:invoices_app/screens/home_screen/home_screen.dart';
import 'package:invoices_app/style/app_color.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final void Function(int) onSelected;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
          iconTheme: MaterialStatePropertyAll(
            IconThemeData(color: AppColor.lightPink, size: 28),
          ),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                fontSize: 16,
                color: AppColor.darkPink,
                letterSpacing: 1.0,
              );
            }
            return const TextStyle(
              fontSize: 16,
              color: AppColor.lightPink,
              letterSpacing: 1.0,
            );
          })),
      child: NavigationBar(
        onDestinationSelected: (int index) {
          widget.onSelected(index);
        },
        backgroundColor: AppColor.navy,
        indicatorColor: AppColor.blue,
        selectedIndex: widget.selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: AppColor.darkPink,
            ),
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Strona główna',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.list,
              color: AppColor.darkPink,
            ),
            icon: Icon(
              Icons.list,
            ),
            label: 'Lista faktur',
          ),
        ],
      ),
    );
  }
}
