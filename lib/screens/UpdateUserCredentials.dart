import 'package:flutter/material.dart';

class UpdateUserCredentials extends StatefulWidget {
  const UpdateUserCredentials({super.key});

  @override
  State<UpdateUserCredentials> createState() => _UpdateUserCredentialsState();
}

class _UpdateUserCredentialsState extends State<UpdateUserCredentials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Text('Update User Credentials'),
      ),
      body: Column(
        
      ),
    );
  }
}
