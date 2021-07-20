import 'package:companion_poc/services/networking.dart';
import 'dart:async' show Future;

const awsURL = 'https://4m5zbiwwfa.execute-api.us-east-1.amazonaws.com/dev';

class WorkspaceModel {
  Future<dynamic> getWorkspaces(String token) async {
    Network dynamoNet = Network(token);
    var dynamoData =
        await dynamoNet.getSpaces('$awsURL/companionUsers/me/workspaces');
    return dynamoData['data'];
  }

  Future<dynamic> bookWorkspace(
      String token, String displayName, String workspaceEmail) async {
    Network dynamoNet = Network(token);
    var dynamoData = await dynamoNet.bookSpace(
        '$awsURL/companionUsers/me/workspaces', displayName, workspaceEmail);
    return dynamoData['data'];
  }
}
