import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/send_message/send_message_cubit.dart';
import 'package:flutter_application_1/data/models/message_model.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

// ignore: must_be_immutable
class ChatBuble extends StatelessWidget {
  ChatBuble({super.key, required this.message
      // required this.message
      });
  MessageModel message;
  // MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.all(10),
        // ignore: sort_child_properties_last
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            text(
              title: message.message ?? ' ',
              color: Colors.white,
              fontSize: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 2),
              child: BlocBuilder<SendMessageCubit, SendMessageState>(
                builder: (context, state) {
                  if (state is SendMessageLoading) {
                    return const Icon(
                      FontAwesomeIcons.clock,
                      size: 10,
                    );
                  } else if (state is SendMessageFailure) {
                    return const Icon(
                      FontAwesomeIcons.exclamation,
                      color: Colors.red,
                      size: 10,
                    );
                  } else
                    // ignore: curly_braces_in_flow_control_structures
                    return const Icon(
                      FontAwesomeIcons.checkDouble,
                      color: Color.fromARGB(255, 0, 94, 255),
                      size: 10,
                    );
                },
              ),
            )
          ],
        ),
        decoration: const BoxDecoration(
            // ignore: unnecessary_const
            color: Color(0xff035D4D),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100))),
      ),
    );
  }
}
