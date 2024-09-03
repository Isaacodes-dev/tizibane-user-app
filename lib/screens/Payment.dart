// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'package:tizibane/Services/PaymentService.dart'; // Import the PaymentService

class Payment extends StatelessWidget {
  // Hardcoded values for subscriberType and amount
  final String subscriberType = "individual";
  final double amount = 150.0;

  // Instantiate the PaymentService
  final PaymentService _paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // Set the background color to black
        title: Text(
          'Tizibane',
          style: GoogleFonts.roboto(
            color: Colors.white, // Set the text color to white
            fontWeight: FontWeight.bold, // Make the text bold
            fontSize: 20, // Set font size
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Pro Plan Section
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pro Individual',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Chip(
                              label: Text(
                                'Popular',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ZMW 150',
                          style: GoogleFonts.roboto(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Per individual, billed annually',
                          style: GoogleFonts.roboto(),
                        ),
                        const SizedBox(height: 20),
                        ListView(
                          shrinkWrap: true,
                          children: const [
                            ListTile(
                              leading: Icon(Icons.check),
                              title: Text('View latest jobs'),
                            ),
                            ListTile(
                              leading: Icon(Icons.check),
                              title: Text('Apply for jobs'),
                            ),
                            ListTile(
                              leading: Icon(Icons.check),
                              title: Text('Get recommended'),
                            ),
                            ListTile(
                              leading: Icon(Icons.check),
                              title: Text('Enhance CV'),
                            ),
                            ListTile(
                              leading: Icon(Icons.check),
                              title: Text('Application progress'),
                            ),
                            ListTile(
                              leading: Icon(Icons.check),
                              title: Text('Apply for future jobs'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Call the payment service when the button is clicked
                              _createPayment(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Subscribe',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createPayment(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please wait, payment processing in progress'),
      ),
    );

    // Call the payment service
    _paymentService
        .makePayment(
      subscriberType: subscriberType,
      subscriberId: '1', // Replace with actual subscriber ID
    )
        .then((success) {
      if (success) {
        Navigator.pushNamed(context, '/login'); // Navigate to login on success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment processing failed.'),
          ),
        );
      }
    });
  }
}
