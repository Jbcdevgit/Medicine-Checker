import 'package:cov_meds/constants/translate_values.dart';
import 'package:cov_meds/constants/values.dart';
import 'package:cov_meds/widgets/input_email_dialouge.dart';
import 'package:cov_meds/widgets/nav_drop_down.dart';
import 'package:cov_meds/widgets/navbar_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tlValues[lang]['appName']),
        actions: [
          NavbarButton(label: tlValues[lang]['navbtns']['0'], onTap: () => inputEmailDialougue(context) ),
          NavDropDownBtn(
            label: tlValues[lang]['navbtns']['1'],
            onChange: (value) {
              lang = value;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            }, 
            items: const [
              {'name': '🇺🇸 English', 'value': 'en'},
              {'name': '🇯🇵 Japanese', 'value': 'jp'},
            ]
          ),
          const SizedBox(width: 20.0,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(tlValues[lang]['homePage']['text']),
      ),
    );
  }
}