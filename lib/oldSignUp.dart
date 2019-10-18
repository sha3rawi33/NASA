import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import './RoundedClipper.dart';

class SignupAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple[300],
            ),
            clipper: RoundedClipper(60),
          ),
          ClipPath(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurpleAccent,
            ),
            clipper: RoundedClipper(50),
          ),
          Positioned(
              top: -50,
              left: -30,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (MediaQuery.of(context).size.height * 0.15) / 2),
                    color: Colors.deepPurple[300].withOpacity(0.3)),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepPurpleAccent),
                  ),
                ),
              )),
          Positioned(
              top: -50,
              left: MediaQuery.of(context).size.width * 0.6,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (MediaQuery.of(context).size.height * 0.20) / 2),
                    color: Colors.deepPurple[300].withOpacity(0.3)),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.deepPurpleAccent),
                  ),
                ),
              )),
          Positioned(
              top: -50,
              left: 80,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (MediaQuery.of(context).size.height * 0.15) / 2),
                    color: Colors.deepPurple[300].withOpacity(0.3)),
              )),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15 - 50),
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static const errors = <String, String>{
    "PASSWORD_NO_MATCH": "Passwords don't match!",
    "ERROR_WEAK_PASSWORD": "Passowrd is weak! Please input a stronger one",
    "ERROR_INVALID_EMAIL": "Email is invalid",
    "ERROR_EMAIL_ALREADY_IN_USE":
    "Email is signed up with a different account!",
    "ERROR_WRONG_PASSWORD": "Passowrd is wrong",
    "ERROR_USER_NOT_FOUND": "The email is not associated with any user",
    "ERROR_USER_DISABLED": "User is disabled",
    "ERROR_TOO_MANY_REQUESTS": "Too many requests by user",
    "ERROR_OPERATION_NOT_ALLOWED": "Operation not allowed"
  };
  FocusNode focusNode1;
  FocusNode focusNode2;
  FocusNode focusNode3;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameContoller = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordContoller = TextEditingController();
  TextEditingController _confrimPasswordContoller = TextEditingController();

  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          SignupAppbar(),
          Builder(
            builder: (context) => Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height * 0.80) - 22,
              margin: EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter name';
                        }
                      },
                      controller: _nameContoller,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Name",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(focusNode1);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validateEmail,
                      controller: _emailContoller,
                      focusNode: focusNode1,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Email",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(focusNode2);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      controller: _passwordContoller,
                      focusNode: focusNode2,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Password",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(focusNode3);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      controller: _confrimPasswordContoller,
                      focusNode: focusNode3,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        contentPadding: new EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () async {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Processing..."),
                            ));
                            _validateInputs();

                            try {
                              var password = _passwordContoller.text;
                              var confirm = _confrimPasswordContoller.text;

                              if (password != confirm)
                                throw PlatformException(
                                    code: "PASSWORD_NO_MATCH");

                              AuthResult result = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: _emailContoller.text,
                                  password: password);
                              await Firestore.instance
                                  .collection('profiles')
                                  .document(result.user.uid)
                                  .setData({
                                'name': _nameContoller.text,
                                'email': _emailContoller.text,
                                'score': 0
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Successfully signed up! Check your email for activation!"),
                              ));
                            } on PlatformException catch (e) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(errors[e.code])));
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.065,
                            decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            print("pressed");
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  shape: BoxShape.circle),
                              child:
                              Icon(Icons.arrow_back, color: Colors.white))),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _value1 = false;
  bool _autoValidate = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be atleast 6 digits';
    else
      return null;
  }

  void signUp() async {}
}