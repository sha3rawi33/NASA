import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './RoundedClipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurple[300],
            ),
            clipper: RoundedClipper(60),
          ),
          ClipPath(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width,
              color: Colors.deepPurpleAccent,
            ),
            clipper: RoundedClipper(50),
          ),
          Positioned(
              top: -110,
              left: -110,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (MediaQuery.of(context).size.height * 0.30) / 2),
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
              top: -100,
              left: 100,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.36,
                width: MediaQuery.of(context).size.height * 0.36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (MediaQuery.of(context).size.height * 0.36) / 2),
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
              left: 60,
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
                Icon(
                  FontAwesomeIcons.userAstronaut,
                  color: Colors.white,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome",
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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode myFocusNode;

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            LoginAppBar(),
            Builder(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 12, 20, 10),
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: "Email",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical:
                                MediaQuery.of(context).size.height * 0.022,
                                horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          onFieldSubmitted: (String value) {
                            FocusScope.of(context).requestFocus(myFocusNode);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: validatePassword,
                          controller: _passwordController,
                          focusNode: myFocusNode,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: "Password",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical:
                                MediaQuery.of(context).size.height * 0.022,
                                horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                activeColor: Colors.deepPurpleAccent,
                                value: _value1,
                                onChanged: _value1Changed,
                              ),
                              Text(
                                "Remember Me",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          child: GestureDetector(
                              onTap: () async {
                                _validateInputs();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Processing..."),
                                ));
                                _validateInputs();

                                try {
                                  AuthResult result= await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  SharedPreferences preference= await SharedPreferences.getInstance();
                                  preference.setString('uid', result.user.uid);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Successfully logged in!"),
                                  ));
                                  Navigator.of(context).pushReplacementNamed('/home');
                                } on PlatformException catch (e) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text(errors[e.code])));
                                }
                              },
                              child: Container(
                                height:
                                MediaQuery.of(context).size.height * 0.065,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                                child: Center(
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Container(
                            margin: EdgeInsets.only(top: 10, bottom: 15),
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/sign-up');
                              },
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "New User?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Signup",
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
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
}