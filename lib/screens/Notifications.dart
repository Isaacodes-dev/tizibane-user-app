import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:tizibane/components/share/ShareUrlLink.dart';
=======
>>>>>>> 77d214542d1a27d1bf6f4f7ac20b4c9a045d85e6

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text('Notifications'),
      ),
      body: const Column(
        children: [Text('Page Coming Soon')],
=======
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
                  const SizedBox(height: 24),
                  const Text(
                    'Recent',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    icon: Icons.circle_notifications,
                    title: 'New Add',
                    subtitle: 'Dr Patrick from EIZ',
                  ),
                  _buildNotificationItem(
                    icon: Icons.circle_notifications,
                    title: 'Membership',
                    subtitle: 'Renew your membership',
                  ),
                  _buildNotificationItem(
                    icon: Icons.circle_notifications,
                    title: 'New Add',
                    subtitle: 'Engineer Andrew',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Last 7 days',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationItem(
                    icon: Icons.circle_notifications,
                    title: 'New Add',
                    subtitle: 'Mr Derick from NAPSA',
                  ),
                  _buildNotificationItem(
                    icon: Icons.circle_notifications,
                    title: 'UPDATES',
                    subtitle: 'New job vacancies',
                  ),
                  _buildNotificationItem(
                    icon: Icons.circle_notifications,
                    title: 'New Add',
                    subtitle: 'Engineer Mwansa from ZESCO',

                  ),
                  //const SizedBox(height: 48),
                  //const Align(
                    //alignment: Alignment.center,
                    //child: Text(
                      //'Privacy & Policy',
                      //style: TextStyle(
                        //color: Colors.grey,
                        //fontSize: 14,
                     // ),
                   // ),
                 // ),
                ],
              ),
            ),
          ],
        ),
>>>>>>> 77d214542d1a27d1bf6f4f7ac20b4c9a045d85e6
      ),
      floatingActionButton: const ShareUrlLink(),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}