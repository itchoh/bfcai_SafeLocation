import 'package:bfcai_safe_zone/auth/widgets/materialButtonWidget.dart';
import 'package:bfcai_safe_zone/auth/widgets/textFormFieldWidget.dart';
import 'package:bfcai_safe_zone/auth/widgets/textRichWidget.dart';
import 'package:firebase_auth/firebase_auth.dart' hide FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/validator_function.dart';
import 'widgets/textFormFieldWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String routeName= "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var email =TextEditingController();
  var password =TextEditingController();
  var confirmPassword =TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 122,),
                Text("Register",
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
                  controller: email,
                  validator: Validator.validateEmail,
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
                  hintText: "Enter Password...",
                  controller: password,
                  validator: Validator.validatePassword,

                ),
                SizedBox(height: 53,),

                Text("Confirme Password",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
                //Don’t have an account? Register
                TextFormFieldWidget(
                  hintText: "Enter Confirme your Password...",
                  controller: confirmPassword,
                  validator:(text) =>Validator.validateConfirmPassword(text,password.text),

                ),
                SizedBox(height: 71,),

                MaterialButtonWidget(
                    title: "Rgister",
                    ontap:()async{
                      if(formKey.currentState!.validate()){
                        var auth = FirebaseAuth.instance;
                        UserCredential user =
                        await auth.createUserWithEmailAndPassword(
                            email: email.text, password: password.text);

                        Navigator.pop(context);
                        setState(() {});


                      }
                    }
                  //{FirebaseAuth.login(password:password.text ,username:username.text );}
                ),
              ],
            ),
          ),
        ),
        //Already have an account? Login
        floatingActionButton: TextRichWidget(
          mainTitle:"Already have an account? " ,
          subTitle:"Login" ,
          onTap:() {Navigator.of(context).pop();},
        )
    );
  }
}