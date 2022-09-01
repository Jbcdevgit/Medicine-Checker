import 'package:cov_meds/constants/const_datas.dart';
import 'package:cov_meds/constants/const_functions.dart';
import 'package:cov_meds/constants/translate_values.dart';
import 'package:cov_meds/constants/values.dart';
import 'package:cov_meds/main.dart';
import 'package:cov_meds/services/authencation_service.dart';
import 'package:cov_meds/services/medicine_service.dart';
import 'package:cov_meds/widgets/form_input_text_field.dart';
import 'package:cov_meds/widgets/med_list_item.dart';
import 'package:cov_meds/widgets/nav_drop_down.dart';
import 'package:cov_meds/widgets/navbar_button.dart';
import 'package:cov_meds/widgets/select_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckMedsScreen extends StatefulWidget {
  const CheckMedsScreen({Key? key}) : super(key: key);
  @override
  _CheckMedsScreenState createState() => _CheckMedsScreenState();
}

class _CheckMedsScreenState extends State<CheckMedsScreen> {
  final medService = MedicineService();
  final medNameController = TextEditingController();
  final authService = AuthenticationService(FirebaseAuth.instance);
  List allMeds = [];
  List filteredMeds = [];
  String covMed = 'clozapine';

  @override
  void initState() {
    super.initState();
    getMedicineList();
    medNameController.addListener(() => filterContacts());
    medNameController.clear();
  }

  filterContacts() {
    List _meds = [];
    _meds.addAll(allMeds);
    if (medNameController.text.isNotEmpty) {
      _meds.retainWhere((usr) {
        String searchTerm = medNameController.text.trim().toLowerCase();
        String contactName = usr.toLowerCase();
        return contactName.substring(0, searchTerm.length) == searchTerm;  
      });

      setState(() => filteredMeds = _meds);
    } else {
      setState(() => filteredMeds = []);
    }
  }

  getMedicineList() async {
    if(lang == 'en') {
      allMeds = await medService.getAllMedsEN();
    } else {
      allMeds = await medService.getAllMedsJP();
    }
    return allMeds;
  }

  onSubmit(String currentMed) async {
    String result = '';
    preventDoubleTap(context);
    if(lang == 'jp') {
      result = await medService.checkMedContradictoryJP(mainDrug: covMed, currentMed: currentMed);
    } else {
      result = await medService.checkMedContradictoryEN(mainDrug: covMed, currentMed: currentMed);
    }
    Navigator.pop(context);
    result = result.replaceAll('{', '');
    result = result.replaceAll('}', '');
    result = result.replaceAll('"', '');
    result = result.replaceAll(':', ':   ');
    result = result.replaceAll('●', '\n');
    result = result.replaceAll('\\r\\n', ':  ');
    showAlertDialougue(context, title: 'Search Result',  content: result);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tlValues[lang]['navbtns']['0']),
        actions: [
          NavDropDownBtn(
            title: Image.asset('assets/images/image.png', height: 18.0,),
            onChange: (value) {
              lang = value;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CheckMedsScreen()));
            }, 
            items: const [
              {'name': '🇺🇸 EN', 'value': 'en'},
              {'name': '🇯🇵 JP', 'value': 'jp'},
            ]
          ),
          NavbarButton(label: 'Logout', onTap: () async {
            await authService.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationWrapper()));
          }),
          const SizedBox(width: 40.0,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text(tlValues[lang]['checkMedicine']['selecbtns']['0']['label'], style: formLabelText,),
              ),
              SelectButton(
                height: 50.0,
                iconSize: 24.0,
                borderRadius: 5.0,
                hintText: tlValues[lang]['checkMedicine']['selecbtns']['0']['hintText'],
                options: medNames,
                dropdownValue: covMed,
                onSelect: (value) {
                  setState(() => covMed = value);
                },
              ),
              const SizedBox(height: 20.0,),
              FormInputTextField(
                label: tlValues[lang]['checkMedicine']['inputFields']['0']['label'],
                controller: medNameController,
                hintText: tlValues[lang]['checkMedicine']['inputFields']['0']['hintText'],
              ),
              for(var medicine in filteredMeds) MedListItem(
                name: medicine, 
                onTap: () {
                  onSubmit(medicine);
                  setState(() {
                    medNameController.clear();
                    filteredMeds = [];
                  });
                }
              ),
              const SizedBox(height: 10.0,),
            ],
          ),
        ),
      ),
    );
  }
}