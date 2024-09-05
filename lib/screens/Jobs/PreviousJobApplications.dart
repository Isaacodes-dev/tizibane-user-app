import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tizibane/Services/Jobs/ApplicationService.dart';

class ApplicationsPage extends StatefulWidget {
  final String individualProfileId;

  const ApplicationsPage({Key? key, required this.individualProfileId})
      : super(key: key);

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  late Future<List<dynamic>> _applicationsFuture;

  @override
  void initState() {
    super.initState();
    _applicationsFuture = ApplicationService()
        .getApplicationsByProfileId(widget.individualProfileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applications'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _applicationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No applications found.'));
          } else {
            final applications = snapshot.data!;

            return ListView.builder(
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final application = applications[index];
                return ListTile(
                  title: Text(application['job']['title'] ?? 'No job title'),
                  subtitle: Text('Status: ${application['status']}'),
                  // You can include more details and customize the ListTile
                );
              },
            );
          }
        },
      ),
    );
  }
}
