// import 'package:cov_meds/constants/translate_values.dart';
// import 'package:cov_meds/constants/values.dart';
// import 'package:cov_meds/main.dart';
// import 'package:cov_meds/services/authencation_service.dart';
// import 'package:cov_meds/widgets/nav_drop_down.dart';
// import 'package:cov_meds/widgets/navbar_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);
//   final authService = AuthenticationService(FirebaseAuth.instance);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(tlValues[lang]['appName']),
//         actions: [
//           NavDropDownBtn(
//             label: tlValues[lang]['navbtns']['1'],
//             onChange: (value) {
//               lang = value;
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
//             }, 
//             items: const [
//               {'name': '🇺🇸 English', 'value': 'en'},
//               {'name': '🇯🇵 Japanese', 'value': 'jp'},
//             ]
//           ),
//           NavbarButton(label: 'Logout', horizontalPadding: 35.0, onTap: () async {
//             await authService.signOut();
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthenticationWrapper()));
//           }),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//         child: Text(tlValues[lang]['homePage']['text']),
//       ),
//     );
//   }
// }