import "package:flutter/material.dart";
class TextRichWidget extends StatelessWidget {
  const TextRichWidget({super.key, required this.mainTitle, required this.subTitle, this.onTap});
  final String mainTitle;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Text.rich(TextSpan(
            children: [
              TextSpan(text: mainTitle),
              TextSpan(text: subTitle,
                  style:TextStyle(
                      color: Color(0xff5F33E1),
                      fontSize: 14
                  ) ),
            ]
        ),
          style: TextStyle(
              fontSize: 13,
              color: Color(0xff6E6A7C)
          ),
        ),
      ),
    );
  }
}
