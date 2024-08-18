import 'package:flutter/material.dart';
import 'package:tizibane/components/SubmitButton.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final List<Map<String, String>> selectorProviders = [
    {'period': '1 Month', 'amount': 'K30'},
    {'period': '3 Months', 'amount': 'K60'},
    {'period': '6 Months', 'amount': 'K90'},
    {'period': '12 Months', 'amount': 'K120'}
  ];
  final List<String> paymentMethodProviders = [
    'Airtel Mobile Money',
    'MTN Mobile Money',
    'Zamtel Mobile Money',
  ];
  Map<String, String>? selectedProvider;
  String? selectedPaymentProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/swish.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/airtel.png',
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/mtn-logo.png',
                    width: 50,
                    height: 50,
                  ),
                  Image.asset(
                    'assets/images/zamtel.png',
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Map<String, String>>(
                value: selectedProvider,
                hint: const Text('Select Subscription'),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (Map<String, String>? newValue) {
                  setState(() {
                    selectedProvider = newValue;
                  });
                },
                items: selectorProviders
                    .map<DropdownMenuItem<Map<String, String>>>(
                        (Map<String, String> value) {
                  return DropdownMenuItem<Map<String, String>>(
                    value: value,
                    child: Text('${value['period']} - ${value['amount']}'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedPaymentProvider,
                hint: const Text('Select Payment Method'),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentProvider = newValue;
                  });
                },
                items: paymentMethodProviders
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
               SubmitButton(text: 'Pay'),
            ],
          ),
        ),
      ),
    );
  }
}
