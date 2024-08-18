// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tizibane/screens/Jobs/JobsFeed.dart';
import 'package:tizibane/screens/Jobs/WebScrappedJobs.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0), // Adjust this value to raise the tabs
              child: const TabBar(
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(text: 'In App Jobs', icon: Icon(Icons.work)),
                  Tab(text: 'Web Jobs', icon: Icon(CupertinoIcons.globe)),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [JobsFeed(), WebScrappedJobs()],
        ),
      ),
    );
  }
}
