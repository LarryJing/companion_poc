import 'package:companion_poc/screens/confirmation_screen.dart';
import 'package:companion_poc/services/workspaces.dart';
import 'package:flutter/material.dart';
import 'workspace_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  final token;
  final mode;
  final displayName;
  final workspaceEmail;
  LoadingScreen(this.token, this.mode, this.displayName, this.workspaceEmail);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    if (widget.mode == 'GET SPACES') {
      getAWSData();
    } else if (widget.mode == 'BOOK SPACE') {
      bookIt(widget.displayName, widget.workspaceEmail);
    }
  }

  void getAWSData() async {
    print('in method');
    var workspaceData = await WorkspaceModel().getWorkspaces(widget.token);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Workspaces(workspaceData, widget.token);
    }));
  }

  void bookIt(var displayName, var workspaceEmail) async {
    await WorkspaceModel()
        .bookWorkspace(widget.token, displayName, workspaceEmail);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfirmationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
