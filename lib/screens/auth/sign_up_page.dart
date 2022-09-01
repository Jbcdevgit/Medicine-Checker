import 'package:cov_meds/constants/const_functions.dart';
import 'package:cov_meds/constants/translate_values.dart';
import 'package:cov_meds/constants/values.dart';
import 'package:cov_meds/screens/home_page.dart';
import 'package:cov_meds/services/authencation_service.dart';
import 'package:cov_meds/services/medicine_service.dart';
import 'package:cov_meds/widgets/app_button.dart';
import 'package:cov_meds/widgets/text_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authService = AuthenticationService(FirebaseAuth.instance);
  final medService = MedicineService();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  userSignUp() async {
    preventDoubleTap(context);
    String msg = await authService.signUp(email: emailController.text.trim());
    Navigator.pop(context);

    if(msg == ' ' || msg == 'existing-user') {
      if(msg == ' ' ) {
        medService.addUserEmail(email: emailController.text.trim());
      }
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showAlertDialougue(context, title: 'Error Found', content: msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tlValues[lang]['appName']),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
            color: Colors.grey.shade200,
            constraints: const BoxConstraints(maxWidth: 400.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 80.0,
                    backgroundImage: NetworkImage('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQMAAADCCAMAAAB6zFdcAAAA1VBMVEX///8At+Udv+giwegrw+klif8kh/8avugjhf8JuuYig/8vnP8wnv8xoP8zo/80pf82qP84rP86r/88s/8+tv8AtOQggP8efP8tmP+c3vM8yOscef87uf9Fxeorlf8adf9Rzu1l0+8XcP8djv5jx/8Ua/902PASZ/8PYv8NXv/W6P6fzv7b9Pu10P7M7/mq4fRvzu2G1/AAU/+51v7b7P5ssv+h0f6l2P+y3v/I6P+D0P/i9vyO2/JNg/6UtP4ATv5rl/4AUf+Cq//Q4v7q8/+Guv6Yxf4xdNOZAAAD/klEQVR4nO3bfVfaMBjGYXmn9QUVpGgVKAzEyAAZog4355R9/4+0gkppmyat0OYk3tefbeA8+QnRw9jODgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAwoajC7rRUPRoCRmenJyk6Ow7X6LCTVCA9ww3ogeM34CdwI4wED1i7DROglRKEz1i3Pq8l4H9QuiLHjJmwxANVD8WT0M0OBU9ZMzQAA0W0AANFtAADRbQAA0W0AANFtAADRbQwG6Q0nhSaKCllP/8IEQD1T9QvOEm0FIz0UPGa6YVeLSC6CHjNUhzExQ0dY7E2eNFxivNfxXYDURPvjWnYbZLTaDMb4VHLf05hZHo0bdlUMh8MkFT9Ohb00z7zoJQ0pboybdmVmDvNKgQK8Hrr3Hvd3Jb2NiA1aCQHVlZ6gJWAvI0Ho+f/iS2hY0NMtkgmebyX1T7Z/4lGVaC56uFp0lSW9hYcINM92ON5V3DTDBeJrh6/p7E+FsR2MBJ4IvATHD1bix/g4zrezauCKESSNUge0aT9XzVyHKWZZkJeh+kb+BNsBaBmaDnuJK8gT/BKgInweWK7A2atJXd5a0u7dYbslZArga0twL9E7JulATSNwhY280yE3RcenI3aAYtZnwTb+JJ0On9iGHaeAzOmn7Rn4Zcdlpul3I3KJCoz0K8BaRvcPE34pNQErQ6kjfovUR6DtJqNXxkakA5Di46jSjvBkIpIH2Dpr2p8BEIrUCj0ZK9gWmGjkAaJpVUDSyfZsMwwkawExhUEjXoBzQwjFARSINewH645A3Mqs0w+Z8ITkyjGkDyBpb5tg1uhIkZVMB+sEQNKAksQ1/iRbAT6IHMaH9jCMVooOsG60wgRnAB+6GviW1hY4++At1RtfihGhyBOKso9HqCe9hU3+p6jar5FT0oAtHzLIZEb4WdnaEvgqXnVvJFegRSzOcYqvOEd7GhgTfCqLi+nTwtAmEWyOv/Et/FhmbDR3eEXLudW+vgj0Ccm0V7sUdtLtF5yPLi7MkXgTj7rkv1vo/q1dlozv13wmTtjiI/8SDzNj3CWoK2ZEdfZNft+krbiTBZv3wtcL4krDdwIkxcV5VvUK856u3p8uK07br6pRrY+63dzm9rnmvqN9h1szftuaJ+A++O/WqqN5ju7vHsTkUPGbPp7j6P+g32uA32lG+wf8Czr36DEo/6DQ64DQ5Ub3BXOuQp3YkeMmZ3pSMe9RscchscKt+Am+DoSP0GxzzKN7g/LvMc34seMmaTEA3k+c8qn1QpV9jKFdEjxu6B2+BB9Ijxuyufs5RVPxGX7s8rgQUq56ofiB/uf36j+/lVCgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAF/UfSKULbSGogbYAAAAASUVORK5CYII='),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20.0,),
                  TextInputField(
                    label: tlValues[lang]['homePage']['inputEmail']['label'],
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return tlValues[lang]['homePage']['inputEmail']['errorText'];
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 30.0,),
                  AppButton(
                    title: 'Continue', 
                    verticalPadding: 15.0,
                    horizontalPadding: 30.0,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        userSignUp();
                      }
                    }
                  ),
                  const SizedBox(height: 25.0,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
