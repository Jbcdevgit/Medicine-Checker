import 'package:cov_meds/constants/const_datas.dart';
import 'package:cov_meds/constants/const_functions.dart';
import 'package:cov_meds/constants/translate_values.dart';
import 'package:cov_meds/constants/values.dart';
import 'package:cov_meds/services/medicine_service.dart';
import 'package:cov_meds/widgets/check_meds/form_input_text_field.dart';
import 'package:cov_meds/widgets/navbar_button.dart';
import 'package:cov_meds/widgets/select_button.dart';
import 'package:flutter/material.dart';

class CheckMedsScreen extends StatefulWidget {
  const CheckMedsScreen({Key? key}) : super(key: key);
  @override
  _CheckMedsScreenState createState() => _CheckMedsScreenState();
}

class _CheckMedsScreenState extends State<CheckMedsScreen> {
  final _formKey = GlobalKey<FormState>();
  final medService = MedicineService();
  static List medsList = [''];
  String? covMed;

  @override
  void dispose() {
    medsList = [''];
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tlValues[lang]['navbtns']['0']),
        actions: [
          NavbarButton(label: 'Submit', horizontalPadding: 30.0, onTap: () async {
            if(_formKey.currentState!.validate()) {
              preventDoubleTap(context);
              String result = await medService.checkMedContradictories(mainDrug: covMed, currentMeds: medsList);
              Navigator.pop(context);
              result = result.replaceAll('{', '');
              result = result.replaceAll('}', '');
              result = result.replaceAll(',', '\n');
              showAlertDialougue(context, title: 'Search Result',  content: result);
            }
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                ...getMedInputItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  List<Widget> getMedInputItems(){
    List<Widget> medTextFields = [];
    for(int i = 0; i < medsList.length; i++){
      medTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: MedicineTextField(i)),
              _addRemoveButton(i == medsList.length-1, i),
            ],
          ),
        )
      );
    }
    return medTextFields;
  }

  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          medsList.insert(medsList.length, '');
        }
        else {
          medsList.removeAt(index);
        }
        setState(() => medsList = medsList);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
        child: Icon((add) ? Icons.add_box : Icons.remove_circle, color: primaryColor, size: 30,),
      ),
    );
  }
}

class MedicineTextField extends StatefulWidget {
  final int index;
  const MedicineTextField(this.index, {Key? key}) : super(key: key);
  @override
  _MedicineTextFieldState createState() => _MedicineTextFieldState();
}

class _MedicineTextFieldState extends State<MedicineTextField> {
  final medTitle = TextEditingController(); 

  @override
  void dispose() {
    medTitle.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      medTitle.text = _CheckMedsScreenState.medsList[widget.index];
    });
    return Column(
      children: [
        FormInputTextField(
          label: tlValues[lang]['checkMedicine']['inputFields']['0']['label'],
          controller: medTitle,
          hintText: tlValues[lang]['checkMedicine']['inputFields']['0']['hintText'],
          onChanged: (v) => _CheckMedsScreenState.medsList[widget.index] = v,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return tlValues[lang]['checkMedicine']['inputFields']['0']['errorEmpty'];
            } else if(value.length > 15) {
              return tlValues[lang]['checkMedicine']['inputFields']['0']['errorCharLimit'];
            }
            return null;
          },
        ),
      ],
    );
  }
}