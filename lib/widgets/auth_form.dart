import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitUserForm);

  final void Function(String email, String userName, String password,
      bool isLogin, BuildContext context) submitUserForm;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _email = '';
  String _password = '';
  bool isLogin = false;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();

      widget.submitUserForm(_email, _userName, _password, isLogin, context);
    }
  }

  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email',
                    icon: Icon(Icons.email),
                  ),
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.length < 7) {
                      return 'username too short';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'username', icon: Icon(Icons.person)),
                  onSaved: (value) {
                    _userName = value;
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value.length < 7) return 'password too short';

                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'password', icon: Icon(Icons.lock)),
                  obscureText: true,
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                RaisedButton(
                    child: Text('Sign Up'),
                    onPressed: () {
                      _trySubmit();
                    }),
                FlatButton(child: Text('Aleardy a user'), onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
