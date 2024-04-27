import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
        Expanded(
          flex: 2,
          child: text(
            title: '    or  login with',
            fontSize: 16,
          ),
        ),
        Expanded(
          flex: 2,
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
