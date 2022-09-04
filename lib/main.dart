import 'package:cov_meds/constants/values.dart';
import 'package:cov_meds/screens/auth/sign_up_page.dart';
import 'package:cov_meds/screens/check_meds.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDUkbMEmQPIxc4VwcLo2rqU6ShVZvcX0Cg",
    authDomain: "medicine-checker-5b3a3.firebaseapp.com",
    projectId: "medicine-checker-5b3a3",
    storageBucket: "medicine-checker-5b3a3.appspot.com",
    messagingSenderId: "294597896559",
    appId: "1:294597896559:web:83e26ec7c78d72f170209a",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Checker',
      theme: ThemeData(
        primarySwatch: primaryColor,
        fontFamily: lang == 'jp' ? "Hiragino Sans" : null,
      ),
      locale: locale,
      supportedLocales: const [locale, Locale('zh', '')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // responsive framework configs --
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: const Color(0xFFdddddd))),
      debugShowCheckedModeBanner: false,
      home: const AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          return const CheckMedsScreen();
        }
        return const SignUpPage();
      },
    );
  }
}
