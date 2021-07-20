import 'package:companion_poc/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart';

class BookingScreen extends StatefulWidget {
  final token;
  final displayName;
  final workspaceEmail;
  BookingScreen(this.token, this.displayName, this.workspaceEmail);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  void initState() {
    super.initState();
  }

  void bookWorkspace(
      String token, String displayName, String workspaceEmail) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoadingScreen(token, 'BOOK SPACE', displayName, workspaceEmail);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.displayName}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            OutlinedButton(
              child: Text('Book this Workspace'),
              onPressed: () {
                bookWorkspace(
                    widget.token, widget.displayName, widget.workspaceEmail);
              },
            ),
            OutlinedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
