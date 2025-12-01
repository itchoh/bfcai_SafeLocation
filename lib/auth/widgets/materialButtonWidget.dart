import 'package:flutter/material.dart';
class MaterialButtonWidget extends StatelessWidget {
  MaterialButtonWidget({super.key, required this.title, this.ontap,this.background=const Color(0xff5F33E1),this.textColor=Colors.white});
 final String title;
 final void Function()? ontap;
 final Color background ;
 final Color textColor ;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      minWidth: double.infinity,
      height: 48,
      onPressed: ontap,
      color: background,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,

        ),
      ),

    );
  }
}
