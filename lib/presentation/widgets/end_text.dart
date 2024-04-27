import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constant.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class EndText extends StatelessWidget {
  EndText({super.key, required this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        text(
          title: title,
          color: CustomColor.kPrimaryColor,
          fontSize: 16,
        ),
      ],
    );
  }
}
