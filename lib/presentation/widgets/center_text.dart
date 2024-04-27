import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constant.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class CenterText extends StatelessWidget {
  CenterText({
    super.key,
    required this.textHint,
    required this.textButton,
    required this.onTap,
  });
  String textHint, textButton;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        text(
          title: textHint,
          fontSize: 16,
          
        ),
        GestureDetector(
          onTap: onTap,
          child: text(
            title: textButton,
            color: CustomColor.kPrimaryColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
