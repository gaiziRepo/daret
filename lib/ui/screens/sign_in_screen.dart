import "package:flutter/material.dart";
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import "package:onboarding_flow/ui/widgets/custom_text_field.dart";
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/business/validator.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_flow/ui/widgets/custom_flat_button.dart';
import 'package:onboarding_flow/ui/widgets/custom_alert_dialog.dart';
import 'package:onboarding_flow/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Password",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(
              'https://coloredbrain.com/wp-content/uploads/2016/07/login-background.jpg',
            ),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            // Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topLeft,
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 120.0),
                            child: Container(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                  'https://i0.wp.com/codecollege.co.za/wp-content/uploads/2016/12/kisspng-dart-programming-language-flutter-object-oriented-flutter-logo-5b454ed3d65b91.767530171531268819878.png?fit=550%2C424&ssl=1'),
                            )
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
                          child: Text(
                            "Sign in",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 50.0,
                              bottom: 10.0,
                              left: 15.0,
                              right: 15.0),
                          child: _emailField,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 20.0, left: 15.0, right: 15.0),
                          child: _passwordField,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 40.0),
                          child: CustomFlatButton(
                            title: "Log In",
                            fontSize: 22,
                            textColor: Colors.white,
                            onPressed: () {
                              _emailLogin(
                                  email: _email.text,
                                  password: _password.text,
                                  context: context);
                            },
                            splashColor: Colors.black12,
                            borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                            borderWidth: 0,
                            color: Colors.lightBlue,
                            icon: null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Container(
                                    height: 1,
                                    margin: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(border: Border.all(width: 0.25), color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "OR CONNECT WITH",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                new Expanded(
                                  child: new Container(
                                    margin: EdgeInsets.all(8.0),
                                    height: 1,
                                    decoration: BoxDecoration(border: Border.all(width: 0.25), color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 40.0),
                          child: CustomFlatButton(
                            title: "Facebook Login",
                            fontSize: 22,
                            textColor: Colors.white,
                            onPressed: () {
                              _facebookLogin(context: context);
                            },
                            splashColor: Colors.black12,
                            borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                            borderWidth: 0,
                            color: Color.fromRGBO(59, 89, 152, 1.0),
                            icon: Icon(FontAwesomeIcons.facebookF, color: Colors.white,),
                          ),
                        ),
                      ],
                    ),
                    SafeArea(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: onBackPress,
                      ),
                    ),
                  ],
                ),
                Offstage(
                  offstage: !_blackVisible,
                  child: GestureDetector(
                    onTap: () {},
                    child: AnimatedOpacity(
                      opacity: _blackVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signIn(email, password)
            .then((uid) => Navigator.of(context).pop());
      } catch (e) {
        print("Error in email sign in: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Login failed",
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  void _facebookLogin({BuildContext context}) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _changeBlackVisible();
      FacebookLogin facebookLogin = new FacebookLogin();
      FacebookLoginResult result = await facebookLogin
          .logIn(['email', 'public_profile']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          Auth.signInWithFacebok(result.accessToken.token).then((uid) {
            Auth.getCurrentFirebaseUser().then((firebaseUser) {
              User user = new User(
                firstName: firebaseUser.displayName,
                userID: firebaseUser.uid,
                email: firebaseUser.email ?? '',
                profilePictureURL: firebaseUser.photoUrl ?? '',
              );
              Auth.addUser(user);
              Navigator.of(context).pop();
            });
          });
          break;
        case FacebookLoginStatus.cancelledByUser:
        case FacebookLoginStatus.error:
          _changeBlackVisible();
      }
    } catch (e) {
      print("Error in facebook sign in: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: "Login failed",
        content: exception,
        onPressed: _changeBlackVisible,
      );
    }
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}
