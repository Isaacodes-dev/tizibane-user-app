import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  // Sample data for active and previous subscriptions
  final List<String> activeSubscriptions = ['Individual Pro'];
  final List<String> previousSubscriptions = [
    'Individual Pro',
    'Individual',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'My Subscriptions',
          style:
              GoogleFonts.lexendDeca(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Subscriptions',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._buildSubscriptionList(activeSubscriptions, true),
                  const SizedBox(height: 24),
                  Text(
                    'Previous Subscriptions',
                    style: GoogleFonts.lexendDeca(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._buildSubscriptionList(previousSubscriptions, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSubscriptionList(
      List<String> subscriptions, bool isActive) {
    return subscriptions.map((subscription) {
      return Card(
        child: ListTile(
          leading: Icon(
            Icons.monetization_on,
            color: isActive ? Colors.green : Colors.red,
          ),
          title: Text(
            subscription,
            style: GoogleFonts.lexendDeca(),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      );
    }).toList();
  }
}
