import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/user.dart';
import 'package:flutter_sqflite/service/login_service.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _pass;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _buildForm(),
    );
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter your email', labelText: "User name"),
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Invalid email.';
              }
              return null; // should return [null] on success
            },
            onSaved: (val) => _username = val,
          ),
          TextFormField(
            obscureText: true, // hide text
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password.';
              }
              return null;
            },
            onSaved: (val) => _pass = val,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: Text('Login'),
              elevation: 10.0,
              textTheme: ButtonTextTheme.accent,
              onPressed: () => _validate(_formKey, context),
            ),
          ),
        ],
      ),
    );
  }

  _validate(GlobalKey<FormState> formState, BuildContext context) async {
    // if form validation is ok
    if (formState.currentState.validate()) {
      formState.currentState.save(); // call 'onSaved' method on every FormField
      LoginService loginService = new LoginService();
      User currentUser = await loginService.login(_username, _pass);
      _handleValidUser(currentUser, context);
    }
  }

  _handleValidUser(User user, BuildContext context) {
    String message = (user != null) ? 'Logged in succesfully!' : 'Login error!';
    
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
