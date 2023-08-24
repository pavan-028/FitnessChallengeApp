import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget{
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  static final Config config = Config(
    tenant: 'YOUR_TENANT_ID',
    clientId: 'YOUR_CLIENT_ID',
    scope: 'openid profile offline_access',
    redirectUri: 'https://login.live.com/oauth20_desktop.srf',
  );
  final AadOAuth oauth = AadOAuth(config);

  @override
  Widget build(BuildContext context) {
    // adjust window size for browser login
    oauth.setWebViewScreenSizeFromMedia(MediaQuery.of(context));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            leading: Icon(Icons.launch),
            title: Text('Login'),
            onTap: () {
              login();
            },
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login() async {
    try {
      await oauth.login();
      var accessToken = await oauth.getAccessToken();
      showMessage('Logged in successfully, your access token: $accessToken');
    } catch (e) {
      showError(e);
    }
  }

  void logout() async {
    await oauth.logout();
    showMessage('Logged out');
  }
}