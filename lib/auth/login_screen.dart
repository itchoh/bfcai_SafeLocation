import 'package:bfcai_safe_zone/auth/registerScreen.dart';
import 'package:bfcai_safe_zone/auth/widgets/materialButtonWidget.dart';
import 'package:bfcai_safe_zone/auth/widgets/textFormFieldWidget.dart';
import 'package:bfcai_safe_zone/auth/widgets/textRichWidget.dart';
import 'package:bfcai_safe_zone/showMap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import '../data/firebase/firebase_auth.dart';
import '../utils/validator_function.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName= "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController username= TextEditingController();
  final TextEditingController password= TextEditingController();
  var formKey=GlobalKey <FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 122,),
              Text("Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 53,),

              Text("Username",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextFormFieldWidget(
                hintText: "enter username...",
                controller: username,
                validator:Validator.validateEmail,
              ),
              SizedBox(height: 53,),

              Text("Password",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
              ),
              //Don’t have an account? Register
              TextFormFieldWidget(
                hintText: "Password...",
                controller: password,
                validator: Validator.validatePassword,

              ),
              SizedBox(height: 71,),

              MaterialButtonWidget(
                  title: "Login",
                  ontap:() async{
                    if(formKey.currentState!.validate()){
                      try{
                        UserCredential userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: username.text,
                            password: password.text);
                        setState(() {});
                        Navigator.of(context).pushNamed(ShowMap.routeName);
                        username.clear();
                        password.clear();
                      }
                      catch(e){}
                    }

                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: TextRichWidget(
        mainTitle:"Don’t have an account? " ,
        subTitle:"Register" ,
        onTap:() {Navigator.of(context).pushNamed(RegisterScreen.routeName);},
      )
      ,
    );
  }
}