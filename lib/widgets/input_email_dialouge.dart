// import 'package:cov_meds/constants/translate_values.dart';
// import 'package:cov_meds/constants/values.dart';
// import 'package:cov_meds/screens/check_meds.dart';
// import 'package:cov_meds/services/medicine_service.dart';
// import 'package:cov_meds/widgets/text_input_field.dart';
// import 'package:flutter/material.dart';

// inputEmailDialougue(context) {
//   final emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final medService = MedicineService();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Align(
//           alignment: Alignment.center,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: Text(tlValues[lang]['homePage']['inputEmail']['header']),
//           ),
//         ),
//         contentPadding: const EdgeInsets.only(top: 40.0, bottom: 40.0, left: 20.0, right: 20.0),
//         content: Wrap(
//           alignment: WrapAlignment.center,
//           children: [
//             Form(
//               key: _formKey,
//               child: TextInputField(
//                 controller: emailController, 
//                 label: tlValues[lang]['homePage']['inputEmail']['label'],
//                 // displayIcon: false,
//                 validator: (value) {
//                   String pattern =
//                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                   RegExp regex = RegExp(pattern);
//                   if (!regex.hasMatch(value!)) {
//                     return tlValues[lang]['homePage']['inputEmail']['errorText'];
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 35.0, width: double.infinity,),
//             TextButton(child: const Text('Continue'), onPressed: () {
//               if(_formKey.currentState!.validate()) {
//                 medService.addUserEmail(email: emailController.text.trim());
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckMedsScreen()));
//               }
//             }),
//           ],
//         ),
//       );
//     },
//   );
// }