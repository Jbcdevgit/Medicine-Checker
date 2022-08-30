import 'package:http/http.dart' as http;

class MedicineService {
  final String serverIP = 'https://covid-drug-medication.herokuapp.com';
  
  Future checkMedContradictories({required String? mainDrug, required List currentMeds}) async {
    Map<String, dynamic> args = {};
    for(var i=0; i<currentMeds.length; i++) {
      args.addEntries({'contradictory_drug[$i]': currentMeds[i]}.entries);
    }

    try {
      var res = await http.post(Uri.parse('$serverIP/covid-drug/search'),
      body: {
          'main_drug': mainDrug,
          ...args
      });
      return res.body;
    } catch (e) {
      return 'Something went wrong. Please try again later.';
    }
  }
}