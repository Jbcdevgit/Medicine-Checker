import 'package:cov_meds/constants/const_datas.dart';
import 'package:cov_meds/constants/const_functions.dart';
import 'package:cov_meds/constants/translate_values.dart';
import 'package:cov_meds/constants/values.dart';
import 'package:cov_meds/services/medicine_service.dart';
import 'package:cov_meds/widgets/check_meds/form_input_text_field.dart';
import 'package:cov_meds/widgets/med_list_item.dart';
import 'package:cov_meds/widgets/navbar_button.dart';
import 'package:cov_meds/widgets/select_button.dart';
import 'package:cov_meds/widgets/selected_med_item.dart';
import 'package:flutter/material.dart';

class CheckMedsScreen extends StatefulWidget {
  const CheckMedsScreen({Key? key}) : super(key: key);
  @override
  _CheckMedsScreenState createState() => _CheckMedsScreenState();
}

class _CheckMedsScreenState extends State<CheckMedsScreen> {
  final medService = MedicineService();
  final medNameController = TextEditingController();
  List selectedMedsList = [];
  List allMeds = [];
  List filteredMeds = [];
  String? covMed;

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
        return contactName.contains(searchTerm);  
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tlValues[lang]['navbtns']['0']),
        actions: [
          NavbarButton(label: 'Submit', horizontalPadding: 30.0, onTap: () async {
            if(selectedMedsList.isNotEmpty || covMed == null) {
              preventDoubleTap(context);
              String result = await medService.checkMedContradictories(mainDrug: covMed, currentMeds: selectedMedsList.toSet().toList());
              Navigator.pop(context);
              result = result.replaceAll('{', '');
              result = result.replaceAll('}', '');
              result = result.replaceAll(',', '\n');
              showAlertDialougue(context, title: 'Search Result',  content: result);
            } else {
              showAlertDialougue(context, title: 'Error Input', content: 'Please select a covid medicine and the current medicine you are taking.');
            }
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  setState(() {
                    selectedMedsList.add(medicine);
                    medNameController.clear();
                    filteredMeds = [];
                  });
                }
              ),
              const SizedBox(height: 10.0,),
              Wrap(
                children: [
                  for(var sItems in selectedMedsList) SelectedMedItem(name: sItems, onTap: () {
                    setState(() {
                      selectedMedsList = selectedMedsList.where((el) => el != sItems).toList();
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}