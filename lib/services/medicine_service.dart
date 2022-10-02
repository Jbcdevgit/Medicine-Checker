import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kana_kit/kana_kit.dart';

class MedicineService {
  final String serverIP = 'https://covid-drug-medication.herokuapp.com';

  Future checkMedContradictoryEN(
      {required String? mainDrug, required String currentMed}) async {
    try {
      var res = await http.post(Uri.parse('$serverIP/covid-drug/search'),
          body: {
            'main_drug': mainDrug,
            'contradictory_drug[0]': currentMed.trim().toLowerCase()
          });
      return res.body;
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }

  Future checkMedContradictoryJP(
      {required String? mainDrug, required String currentMed}) async {
    if (currentMed.trim().contains('「')) {
      currentMed = currentMed.trim().split('「')[0];
    } else if (currentMed.trim().contains('ＯＤ')) {
      currentMed = currentMed.trim().split('ＯＤ')[0];
    }
    const kanaKit = KanaKit();
    currentMed = kanaKit.toKatakana(currentMed);

    try {
      var res = await http.post(Uri.parse('$serverIP/covid-drug-jp/search'),
          body: {'main_drug': mainDrug, 'contradictory_drug[0]': currentMed});
      return res.body;
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }

  Future runTestLoop() async {
    var data = [];
    List res = await getAllMedsJP();
    for (var m in res) {
      var d =
          await checkMedContradictoryJP(mainDrug: 'clozapine', currentMed: m);
      data.add(d);
    }
    // print(data);
  }

  Future getAllMedsJP() async {
    try {
      var res = await http.get(Uri.parse('$serverIP/covid-drug-jp/all'));
      return json.decode(res.body);
    } catch (e) {
      return [];
    }
  }

  Future getAllMedsEN() async {
    try {
      var res = await http.get(Uri.parse('$serverIP/covid-drug/all'));
      return json.decode(res.body);
    } catch (e) {
      return [];
    }
  }

  Future addUserEmail({required String? email}) async {
    try {
      var res = await http.post(Uri.parse('$serverIP/doctor-email/start'),
          body: {'email': email});
      return res.body;
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }

  Future getAllEmails() async {
    try {
      var res = await http.get(Uri.parse('$serverIP/doctor-email/all'));
      return json.decode(res.body);
    } catch (e) {
      return [];
    }
  }
}
