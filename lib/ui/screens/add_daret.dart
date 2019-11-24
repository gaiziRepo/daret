import "package:flutter/material.dart";
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/ui/widgets/CheckBox.dart';
import "package:onboarding_flow/ui/widgets/custom_text_field.dart";
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/business/validator.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_flow/ui/widgets/custom_flat_button.dart';
import 'package:onboarding_flow/ui/widgets/custom_alert_dialog.dart';
import 'package:onboarding_flow/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class addDaretScreen extends StatefulWidget {
  _addDaretScreenState createState() => _addDaretScreenState();
}

class _addDaretScreenState extends State<addDaretScreen> {
  VoidCallback onBackPress;
  Color color1 = Color(0xff38bbad);
  Color color2 = Color(0xff2b7a98);
  String loggedUser;
  double contribution = 200;
  bool monthly = false;
  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    Auth.getCurrentFirebaseUser().then((user) {
      setState(() {
        if (user != null) {
          loggedUser = user.uid;
        }
        /*authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;*/
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          appBar: _buildAppBar(context),
          backgroundColor: Colors.white,
          body: StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              return Container(
                  width: width,
                  height: height,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Column(
                      children: <Widget>[
                        buildNameForm(),
                        buildContributionForm(),
                        buildPeriodForm()
                      ],
                    ),
                  ));
            },
          ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff38bbad),
              Color(0xff2b7a98)
            ],
          ),
        ),
      ),
      titleSpacing: 0.0,
      elevation: 1,
      backgroundColor: Colors.white,
      title: Text(
        "Créer une tontine",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildNameForm() {
    return Container(
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey , width: 0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
      color: Colors.white,
      elevation: 0,
      child: Column(
        children: <Widget>[
          buildBodyCardTitle(title: "Nom de la tontine"),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5),
            child: CustomTextField(
              baseColor: Colors.grey,
              borderColor: Colors.grey[400],
              errorColor: Colors.red,
              hint: "Nom",
              inputType: TextInputType.text,
            ),
          )
        ],
      ),
    ));
  }

  Widget buildContributionForm() {
    return Container(
        height: 150,
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey , width: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: Column(
            children: <Widget>[
              buildBodyCardTitle(title: "Cotisation mensuelle par personne"),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                child: CustomTextField(
                  baseColor: Colors.grey,
                  borderColor: Colors.grey[400],
                  errorColor: Colors.red,
                  hint: "Montent de la cotisation",
                  inputType: TextInputType.number,
                ),
              )
            ],
          ),
        ));
  }

  Widget buildPeriodForm() {
    return Container(
        height: 200,
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey , width: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: Column(
            children: <Widget>[
              buildBodyCardTitle(title: "Cotisation mensuelle par personne"),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                child: Column(
                  children: <Widget>[
                    PCheckboxListTile(
                      title: 'Hebdomadaire',
                      color: Colors.green,
                      selectedColor: Colors.green,
                      value: !monthly,
                      onChanged: (value) {
                        setState(() {
                          monthly = !value;
                        });
                      },
                    ),
                    PCheckboxListTile(
                      title: 'Mensuel',
                      value: monthly,
                      color: Colors.green,
                      selectedColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          monthly = value;
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
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
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
