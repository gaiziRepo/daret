import 'package:cloud_firestore/cloud_firestore.dart';

class Tontine {
  final String adminUserID;
  final String name;
  final String contribution;
  final String frequency;
  final Timestamp startDate;
  final Map<String, int> users;

  Tontine({
    this.adminUserID,
    this.name,
    this.contribution,
    this.frequency,
    this.startDate,
    this.users,
  });

  Map<String, Object> toJson() {
    return {
      'adminUserID': adminUserID,
      'name': name,
      'contribution': contribution == null ? '' : contribution,
      'frequency': frequency,
      'startDate': startDate,
      'users': users,
      'appIdentifier': 'flutter-onboarding'
    };
  }

  factory Tontine.fromJson(Map<String, Object> doc) {
    Tontine tontine = new Tontine(
      adminUserID: doc['adminUserID'],
      name: doc['name'],
      contribution: doc['contribution'],
      frequency: doc['frequency'],
      startDate: doc['startDate'],
      users: doc['users']
    );
    return tontine;
  }

  factory Tontine.fromDocument(DocumentSnapshot doc) {
    return Tontine.fromJson(doc.data);
  }
}
