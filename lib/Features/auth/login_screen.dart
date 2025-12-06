import 'package:bfcai_safe_zone/Features/auth/registerScreen.dart';
import 'package:bfcai_safe_zone/Features/auth/widgets/materialButtonWidget.dart';
import 'package:bfcai_safe_zone/Features/auth/widgets/textFormFieldWidget.dart';
import 'package:bfcai_safe_zone/Features/auth/widgets/textRichWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constant/TextStyles.dart';
import '../../core/utils/validator_function.dart';
import '../Map_Location/showMap.dart';

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
                style:  Styles.text_Style32
              ),
              SizedBox(height: 53,),
              Text("Username",
                style: Styles.text_Style16
              ),
              TextFormFieldWidget(
                hintText: "enter username...",
                controller: username,
                validator:Validator.validateEmail,
              ),
              SizedBox(height: 53,),
              Text("Password",
                style:  Styles.text_Style16
              ),
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
              TextRichWidget(
                mainTitle:"Don’t have an account? " ,
                subTitle:"Register" ,
                onTap:() {Navigator.of(context).pushNamed(RegisterScreen.routeName);},
              ),
            ],
          ),
        ),
      ),
    );
  }
}