import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flow/business/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onboarding_flow/models/user.dart';
import 'package:onboarding_flow/ui/screens/profile_screen.dart';
import 'package:onboarding_flow/ui/widgets/custom_flat_button.dart';

class MainScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  MainScreen({this.firebaseUser});

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    print(widget.firebaseUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(248, 245, 244, 1.0),
        body: StreamBuilder(
          stream: Auth.getUser(widget.firebaseUser.uid),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(212, 20, 15, 1.0),
                  ),
                ),
              );
            } else {
              return _getPage(currentPage, widget.firebaseUser);
            }
          },
        ),
        bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(iconData: Icons.home, title: "Home"),
              TabData(iconData: Icons.notifications, title: "Notifications"),
              TabData(iconData: Icons.person, title: "profile")
            ],
            onTabChangedListener: (position) {
              setState(() {
                currentPage = position;
              });
            },
            circleColor: Colors.teal,
            inactiveIconColor: Colors.teal));
  }

  _getPage(int page, FirebaseUser user) {
    switch (page) {
      case 0:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 400.0,
                width: 400.0,
                child: Image.asset('assets/images/social_network.gif'),
              ),
              Text(
                "Gérer votre tontine",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  fontFamily: "OpenSans",
                ),
              ),
              Text(
                "en toute simplicité",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.none,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  fontFamily: "OpenSans",
                ),
              ),
              Container(
                height: 30,
              ),
              CustomFlatButton(
                title: "Créer une tontine",
                fontSize: 22,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed("/add");
                },
                splashColor: Colors.black12,
                borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                borderWidth: 0,
                color: Colors.teal,
                icon: Icon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      case 2:
        return new ProfileScreen(firebaseUser: user);
      default:
        return Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "This is the notification page",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                decoration: TextDecoration.none,
                fontSize: 30.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                fontFamily: "OpenSans",
              ),
            ),
          ],
        ));
    }
  }

  void _logOut() async {
    Auth.signOut();
  }
}
