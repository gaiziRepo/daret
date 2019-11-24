import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flow/business/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onboarding_flow/models/user.dart';
import 'package:onboarding_flow/ui/widgets/custom_flat_button.dart';

class ProfileScreen extends StatefulWidget {
  final FirebaseUser firebaseUser;

  ProfileScreen({this.firebaseUser});

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color color1 = Color(0xff38bbad);
  Color color2 = Color(0xff2b7a98);

  @override
  void initState() {
    super.initState();
    print(widget.firebaseUser);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
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
            return Container(
              width: width,
              height: height,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: width,
                    height: height * .30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color1, color2],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  buildHeader(width, height),
                  buildHeaderData(height, width, snapshot.data),
                  buildHeaderInfoCard(height, width),
                  buildNotificationPanel(width, height),
                  /*  buildBottomBar(width),
            buildFloatingButton(width, height),*/
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildHeader(double width, double height) {
    return Positioned(
      top: 30,
      child: Container(
        width: width,
        height: height * .30,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "DARET",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        onPressed: _logOut,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeaderData(double height, double width, User user) {
    return Positioned(
      top: (height * .30) / 2 - 40,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage('assets/images/avatar_male.png'),
                )),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hi ${user.firstName}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                ", Good Morning",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
          Text(
            "Today, 22 Nov 2019",
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget buildHeaderInfoCard(double height, double width) {
    return Positioned(
      top: height * .30 - 25,
      width: width,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          height: 50,
          width: width * .65,
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("  Payment due"),
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_downward, color: Colors.red),
                        Text(
                          "1200 \$",
                          style: TextStyle(
                            color: Color(0xff053150),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.access_time,
                  size: 35,
                  color: Colors.grey,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Incoming payment"),
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_upward, color: Colors.green),
                        Text(
                          "0 \$",
                          style: TextStyle(
                            color: Color(0xff053150),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomBar(double width) {
    return Positioned(
      bottom: 0,
      width: width,
      child: Container(
        height: 55,
        width: width,
        color: Colors.white,
        child: Material(
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: width / 3,
                child: Icon(
                  Icons.account_circle,
                  size: 35,
                  color: Color(0xff065967).withOpacity(0.7),
                ),
              ),
              Container(width: width / 3),
              Container(
                width: width / 3,
                child: Icon(
                  Icons.assessment,
                  size: 35,
                  color: Color(0xff065967).withOpacity(0.7),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFloatingButton(double width, double height) {
    return Positioned(
      top: height - 85,
      width: width,
      child: Container(
        height: 70,
        width: 70,
        child: RawMaterialButton(
          shape: CircleBorder(),
          fillColor: Color(0xff1a9bb1),
          elevation: 4,
          onPressed: () {},
          child: Icon(
            Icons.menu,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildNotificationPanel(double width, double height) {
    return Positioned(
      width: width,
      height: height * .70 - 40,
      top: height * 0.30 + 34,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Material(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    buildBodyCardTitle(title: "Transactions"),
                    Divider(
                      height: 3,
                      color: Colors.black87,
                    ),
                    buildNotificationItem(
                        icon: Icons.arrow_upward,
                        data: "1200",
                        color: Colors.green),
                    Divider(
                      height: 3,
                      color: Colors.black87,
                    ),
                    buildNotificationItem(
                        icon: Icons.arrow_downward,
                        data: "600",
                        color: Colors.red),
                    Divider(
                      height: 3,
                      color: Colors.black87,
                    ),
                    buildNotificationItem(
                        icon: Icons.arrow_upward,
                        data: "800",
                        color: Colors.green),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Material(
                elevation: 1,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildBodyCardTitle(title: "My daret"),
                    Divider(
                      height: 2,
                      color: Colors.black87,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      leading: Card(
                        elevation: 2,
                        child: Container(
                          height: 70,
                          width: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "MAY",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "21",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Daret beta",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "This month beneficiary",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "PENDING",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 70,
                        width: 80,
                        padding: const EdgeInsets.only(right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "\$1200",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff1abcaa),
                              ),
                              child: Text(
                                "PAY NOW",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBodyCardTitle({String title}) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Color(0xff06866C),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationItem({IconData icon, String data, Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: Colors.white70,
          ),
        ),
        title: Text(
          "From Hamza",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data + "\$",
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Transaction finished",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        trailing: Container(
          height: 40,
          width: 70,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1,
                color: Colors.black26,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 15,
                ),
                Text(
                  " 1 Day",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  void _logOut() async {
    Auth.signOut();
  }
}
