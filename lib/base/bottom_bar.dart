import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:learningzed/base/res/styles/app_styles.dart';
import 'package:learningzed/screens/add_devices_screen.dart';
import 'package:learningzed/screens/devices_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  int indexoff = 0;
  static List<Widget> widgetPage = [
    const DevicesScreen(),
    const AddDevicesScreen(),
  ];

  void itemtapped(int index) {
    setState(() {
      indexoff = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: widgetPage[indexoff]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppStyles.thirdColor,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GradientIcon(
                icon: FluentSystemIcons.ic_fluent_phone_desktop_regular,
                size: 30,
                gradient: LinearGradient(colors: [
                  AppStyles.secondaryColor,
                  AppStyles.primaryColor,
                ])),
            activeIcon: GradientIcon(
                icon: FluentSystemIcons.ic_fluent_phone_desktop_filled,
                size: 35,
                gradient: LinearGradient(colors: [
                  AppStyles.secondaryColor,
                  AppStyles.primaryColor,
                ])),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: GradientIcon(
                icon: Icons.add_box_outlined,
                size: 30,
                gradient: LinearGradient(colors: [
                  AppStyles.secondaryColor,
                  AppStyles.primaryColor,
                ])),
            activeIcon: GradientIcon(
                icon: Icons.add_box_rounded,
                size: 35,
                gradient: LinearGradient(colors: [
                  AppStyles.secondaryColor,
                  AppStyles.primaryColor,
                ])),
            label: 'New',
          ),
        ],
        currentIndex: indexoff,
        onTap: itemtapped,
        selectedIconTheme: const IconThemeData(size: 30),
        selectedLabelStyle: TextStyle(fontSize: 13, color: AppStyles.thirdColor),
      ),
    );
  }
}
