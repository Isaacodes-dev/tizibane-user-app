import 'package:flutter/material.dart';
import 'package:tizibane/screens/Contacts.dart';
import 'package:tizibane/screens/Home.dart';
import 'package:tizibane/screens/Jobs/JobsFeed.dart';
import 'package:tizibane/screens/More.dart';

class BottomMenuBarItems extends StatefulWidget {
  final int selectedIndex;

  const BottomMenuBarItems({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<BottomMenuBarItems> createState() => _BottomMenuBarItemsState();
}

class _BottomMenuBarItemsState extends State<BottomMenuBarItems> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: getCurrentScreen(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMaterialButton(0, Icons.home_filled, "Home"),
                buildMaterialButton(1, Icons.contacts_outlined, "Contacts"),
                buildMaterialButton(2, Icons.work, "Jobs"),
                buildMaterialButton(3, Icons.more_horiz_outlined, "More"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCurrentScreen() {
    switch (currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const Contacts();
      case 2:
        return const JobsFeed();
      case 3:
        return const More();
      default:
        return const Home();
    }
  }

  MaterialButton buildMaterialButton(int index, IconData icon, String label) {
    return MaterialButton(
      minWidth: 50,
      onPressed: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: currentIndex == index ? Colors.orange : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
                color: currentIndex == index ? Colors.orange : Colors.white),
          ),
        ],
      ),
    );
  }
}
