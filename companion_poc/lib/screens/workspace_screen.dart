import 'package:companion_poc/screens/booking_screen.dart';
import 'package:flutter/material.dart';

import 'landing_screen.dart';

class Workspaces extends StatefulWidget {
  final data;
  final token;
  Workspaces(this.data, this.token);

  @override
  _WorkspacesState createState() => _WorkspacesState();
}

class _WorkspacesState extends State<Workspaces> {
  @override
  void initState() {
    super.initState();
  }

  void confirmBooking(
      String token, String displayName, String spaceEmail) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookingScreen(token, displayName, spaceEmail);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Book A Workspace',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 400,
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        color: Colors.white24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ElevatedButton(
                                child: Column(
                                  children: [
                                    Text(
                                      '${widget.data[index][0]}',
                                    ),
                                    Text(
                                        'Teammates present: ${widget.data[index][1]}'),
                                  ],
                                ),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  confirmBooking(
                                      widget.token,
                                      widget.data[index][0],
                                      widget.data[index][2]);
                                },
                              ),
                            ),
                          ],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    thickness: 3,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LandingScreen();
                        }));
                      },
                      child: const Text('Back to Landing Page'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
