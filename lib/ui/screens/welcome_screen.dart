import 'package:flutter/material.dart';
import 'package:onboarding_flow/ui/widgets/custom_flat_button.dart';

class WelcomeScreen extends StatelessWidget {
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: new ListView(
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
                  "DARET",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Le service idéal pour faciliter et sécuriser vos tontines",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: "OpenSans",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: CustomFlatButton(
                  title: "Log In",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signin");
                  },
                  splashColor: Colors.black12,
                  borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                  borderWidth: 0,
                  color: Colors.lightBlue,
                  icon: null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: CustomFlatButton(
                  title: "Sign Up",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/signup");
                  },
                  splashColor: Colors.white12,
                  borderColor: Colors.white,
                  borderWidth: 2,
                  icon: null,
                ),
              ),
            ],
          ),
        ));
  }
}
