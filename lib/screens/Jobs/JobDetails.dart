import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Tizibane Solutions",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(),
          Positioned(
              top: 50,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFFFFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            'assets/images/tizibaneicon.png',
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Senior Software Developer"),
                        SizedBox(
                          height: 20,
                        ),
                        Text("House of Luanshya, Luanshya"),
                        Row(
                          children: [],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Qualifications"),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
