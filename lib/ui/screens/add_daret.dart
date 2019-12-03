import "package:flutter/material.dart";
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/ui/widgets/custom_flat_button.dart';
import "package:onboarding_flow/ui/widgets/custom_text_field.dart";
import 'package:flutter/services.dart';
import 'package:onboarding_flow/models/user.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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
  String _date =
      '${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}';
  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

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
                  child: Stack(children: <Widget>[
                    Form(
                      child: Stepper(
                        type: StepperType.horizontal,
                        controlsBuilder: _createEventControlBuilder,
                        currentStep: _currentStep,
                        onStepTapped: (int step) =>
                            setState(() => _currentStep = step),
                        onStepContinue: _currentStep < 1
                            ? () => setState(() => _currentStep += 1)
                            : null,
                        onStepCancel: _currentStep > 0
                            ? () => setState(() => _currentStep -= 1)
                            : null,
                        steps: [
                          Step(
                              title: Text(""),
                              isActive: _currentStep == 0,
                              state: _currentStep > 0
                                  ? StepState.complete
                                  : StepState.disabled,
                              content: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    buildNameForm(),
                                    buildContributionForm(),
                                    buildStartDateForm(),
                                  ],
                                ),
                              )),
                          Step(
                            isActive: _currentStep == 1,
                            title: Text(""),
                            content: addMemberStepContent(),
                          )
                        ],
                      ),
                    ),
                    stepperButton(context)
                  ]));
            },
          ),
        ));
  }

  Widget addMemberStepContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          addMemberForm(),
        ],
      ),
    );
  }

  Widget addMemberForm() {
    return Container(
        height: 170,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.people,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(width: 10),
                      Text('Ajouter des participants',
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                          )),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5, bottom: 2),
                child: CustomTextField(
                  height: 50,
                  verticalPad: 0,
                  baseColor: Colors.grey,
                  borderColor: Colors.grey[400],
                  errorColor: Colors.red,
                  hint: "Nom",
                  inputType: TextInputType.text,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: <Widget>[
                      Container(width:205,
                      child:CustomTextField(
                        height: 50,
                        verticalPad: 1,
                        baseColor: Colors.grey,
                        borderColor: Colors.grey[400],
                        errorColor: Colors.red,
                        hint: "Email",
                        inputType: TextInputType.text,
                      )),
                    ],
                  )),

            ],
          ),
        ));
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  Widget stepperButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  onPressed: _currentStep == 0 ? null : () => _onStepCancel(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: Colors.teal,
                      width: 0.5,
                    ),
                  ),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.navigate_before),
                      Text('Retour',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  onPressed: _currentStep == 1 ? null : () => _onStepContinue(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: Colors.teal,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('Suivant',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ],
            )));
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
            colors: <Color>[Color(0xff38bbad), Color(0xff2b7a98)],
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
            side: BorderSide(color: Colors.grey, width: 0.2),
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
            side: BorderSide(color: Colors.grey, width: 0.2),
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

  Widget buildStartDateForm() {
    return Container(
        height: 150,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.white,
          elevation: 0,
          child: Column(
            children: <Widget>[
              buildBodyCardTitle(title: "Date de début"),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5),
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 0.0,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              doneStyle:
                                  TextStyle(color: Colors.teal, fontSize: 16),
                              containerHeight: 230.0,
                            ),
                            locale: LocaleType.fr,
                            showTitleActions: true,
                            minTime: DateTime(2012, 1, 1),
                            maxTime: DateTime(2028, 12, 31), onConfirm: (date) {
                          print('confirm $date');
                          _date = '${date.year} - ${date.month} - ${date.day}';
                          setState(() {});
                        }, currentTime: DateTime.now());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 65.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.teal,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                      ),
                                      Text(
                                        " $_date",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "  Modifier",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
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
