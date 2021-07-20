import 'package:companion_poc/screens/loading_screen.dart';
import 'package:companion_poc/services/sso.dart';
import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'package:msal_mobile/msal_mobile.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late MsalMobile msal;
  bool isSignedIn = false;
  SSO auth = new SSO();
  var userToken = "";

  void initState() {
    super.initState();
    MsalMobile.create('assets/auth_config.json',
            "https://login.microsoftonline.com/67bff79e-7f91-4433-a8e5-c9252d2ddc1d/oauth2/v2.0/authorize")
        .then((client) {
      setState(() {
        msal = client;
      });
    });
  }

  /// Updates the signed in state
  refreshSignedInStatus() {
    msal.getSignedIn().then((loggedIn) {
      setState(() {
        isSignedIn = loggedIn;
      });
    });
  }

  void getWorkspaces() async {
    print('token before workspaces: $userToken');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoadingScreen(userToken, 'GET SPACES', '', '');
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
            // TextButton(
            //   style: TextButton.styleFrom(
            //     primary: Colors.white,
            //     textStyle: TextStyle(fontSize: 30),
            //   ),
            //   onPressed: () {
            //     getWorkspaces('lawrence.jing@autodesk.com');
            //   },
            //   child: Text('Lawrence'),
            // ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     primary: Colors.white,
            //     textStyle: TextStyle(fontSize: 30),
            //   ),
            //   onPressed: () {
            //     getWorkspaces('phoebe.tan@autodesk.com');
            //   },
            //   child: Text('Phoebe'),
            // ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     primary: Colors.white,
            //     textStyle: TextStyle(fontSize: 30),
            //   ),
            //   onPressed: () {
            //     getWorkspaces('rachel.liu@autodesk.com');
            //   },
            //   child: Text('Rachel'),
            // ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     primary: Colors.white,
            //     textStyle: TextStyle(fontSize: 30),
            //   ),
            //   onPressed: () {
            //     getWorkspaces('james.junior@autodesk.com');
            //   },
            //   child: Text('James'),
            // ),
            ElevatedButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(fontSize: 30),
                padding: EdgeInsets.all(8),
              ),
              onPressed: () async {
                isSignedIn
                    ? getWorkspaces()
                    : userToken = await auth.signin(msal);
                refreshSignedInStatus();
              },
              child: Text('Book a Workspace'),
            ),
            isSignedIn
                ? ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 30),
                      padding: EdgeInsets.all(8),
                    ),
                    child: Text("Sign Out"),
                    onPressed: () async {
                      await auth.signout(msal);
                      refreshSignedInStatus();
                    },
                  )
                : ElevatedButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: TextStyle(fontSize: 30),
                      padding: EdgeInsets.all(8),
                    ),
                    child: Text("Sign In"),
                    onPressed: () async {
                      refreshSignedInStatus();
                      await auth.signin(msal);
                      userToken = await auth.getToken(msal);
                      // userToken = msal.acquireTokenSilent(scopes, authority)
                      // print('user token: $userToken');
                      refreshSignedInStatus();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
