import 'package:msal_mobile/msal_mobile.dart';
import 'package:companion_poc/constants/constants.dart';

class SSO {
  SSO();
  var token = '';

  logMsalMobileError(MsalMobileException exception) {
    print('${exception.errorCode}: ${exception.message}');
    if (exception.innerException != null) {
      print(
          'inner exception = ${exception.innerException.errorCode}: ${exception.innerException.message}');
    }
  }

  signin(MsalMobile msal) async {
    try {
      await msal.signIn(null, [SCOPE]).then((result) {
        // print('access token (truncated): ${result.accessToken}');
        token = result.accessToken;
        return result.accessToken;
      });
    } on MsalMobileException catch (exception) {
      logMsalMobileError(exception);
    }
  }

  signout(MsalMobile msal) async {
    try {
      await msal.signOut();
      print('signout done');
    } on MsalMobileException catch (exception) {
      logMsalMobileError(exception);
    }
  }

  /// Gets a token silently unless the interactive experience is required.
  getToken(MsalMobile msal) async {
    // you would use this instead to auth for all organizations: "https://login.microsoftonline.com/common"
    await msal.acquireToken([SCOPE], authority).then((result) {
      print('access token (truncated): ${result.accessToken}');
      token = result.accessToken;
    }).catchError((exception) {
      if (exception is MsalMobileException) {
        logMsalMobileError(exception);
      } else {
        print('exception occurred');
      }
    });
    return token;
  }
}
