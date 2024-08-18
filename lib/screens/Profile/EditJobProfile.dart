import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:google_fonts/google_fonts.dart';

class EditJobProfile extends StatefulWidget {
  const EditJobProfile({super.key});

  @override
  State<EditJobProfile> createState() => _EditJobProfileState();
}

class _EditJobProfileState extends State<EditJobProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Accordion(
                maxOpenSections: 1,
                children: [
                  AccordionSection(
                    headerBackgroundColor: Colors.black,
                    contentBorderColor: Colors.black,
                    headerPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    isOpen: true,
                    header: Text('About',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                    content: Column(
                      children: [
                        ListTile(title: Text('Item 1.1')),
                      ],
                    ),
                  ),
                  AccordionSection(
                    headerBackgroundColor: Colors.black,
                    contentBorderColor: Colors.black,
                    headerPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    header: Text('Education',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                    content: Column(
                      children: [
                        ListTile(title: Text('Item 1.1')),
                        ListTile(title: Text('Item 1.2')),
                      ],
                    ),
                  ),
                  AccordionSection(
                    headerBackgroundColor: Colors.black,
                    headerPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    contentBorderColor: Colors.black,
                    header: Text('Skills',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                    content: Column(
                      children: [
                        ListTile(title: Text('Item 2.1')),
                        ListTile(title: Text('Item 2.2')),
                      ],
                    ),
                  ),
                  AccordionSection(
                    headerBackgroundColor: Colors.black,
                    headerBorderColorOpened: Colors.black,
                    contentBorderColor: Colors.black,
                    headerPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    header: Text('Experience',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                    content: Column(
                      children: [
                        ListTile(title: Text('Item 3.1')),
                        ListTile(title: Text('Item 3.2')),
                      ],
                    ),
                  ),
                  AccordionSection(
                    headerBackgroundColor: Colors.black,
                    headerBorderColorOpened: Colors.black,
                    contentBorderColor: Colors.black,
                    headerPadding:
                        EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    header: Text('Professsional Affiliations',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                    content: Column(
                      children: [
                        ListTile(title: Text('Item 3.1')),
                        ListTile(title: Text('Item 3.2')),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
