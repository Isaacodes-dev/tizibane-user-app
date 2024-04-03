import 'package:flutter/material.dart';
import 'package:tizibane/screens/Contacts.dart';
import 'package:tizibane/screens/Home.dart';
import 'package:tizibane/screens/More.dart';
import 'package:tizibane/screens/Profile.dart';

class BottomMenuBarItems extends StatefulWidget {
  final int selectedIndex = 0;
  

  const BottomMenuBarItems({Key? key}) : super(key: key);

  @override
  State<BottomMenuBarItems> createState() => _BottomMenuBarItemsState();
}

class _BottomMenuBarItemsState extends State<BottomMenuBarItems> {

  int currentIndex = 0;

  @override
  void initState()
  {
    super.initState();
  }

  // final List<Widget> pages =[
  //   Home(nrc: widget.nrc),
  //   Profile(),
  //   Contacts(),
  //   More()
  // ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Widget currentScreen = currentIndex == 0 ? Home() : currentIndex == 1 ? Contacts() : currentIndex == 2 ? Profile() : More();
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                minWidth: 50,
                onPressed: (){
                  setState(() {
                    currentScreen = Home();
                    currentIndex = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_filled,
                      color: currentIndex == 0 ? Colors.orange : Colors.white,
                    ),
                    Text("Home", style: TextStyle(color: currentIndex == 0 ? Colors.orange : Colors.white),),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 50,
                onPressed: (){
                  setState(() {
                    currentScreen = Contacts();
                    currentIndex = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.contacts_outlined,
                      color: currentIndex == 1 ? Colors.orange : Colors.white,
                    ),
                    Text("Contacts", style: TextStyle(color: currentIndex == 1 ? Colors.orange : Colors.white),),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 50,
                onPressed: (){
                  setState(() {
                    currentScreen = Profile();
                    currentIndex = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: currentIndex == 2 ? Colors.orange : Colors.white,
                    ),
                    Text("Profile", style: TextStyle(color: currentIndex == 2 ? Colors.orange : Colors.white),),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 50,
                onPressed: (){
                  setState(() {
                    currentScreen = More();
                    currentIndex = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.more_horiz_outlined,
                      color: currentIndex == 3 ? Colors.orange : Colors.white,
                    ),
                    Text("More", style: TextStyle(color: currentIndex == 3 ? Colors.orange : Colors.white),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}