import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/send_message/send_message_cubit.dart';
import 'package:flutter_application_1/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
// import 'package:flutter_application_1/models/message_model.dart';

// ignore: must_be_immutable
class ChatBubleOther extends StatelessWidget {
  ChatBubleOther({super.key, required this.message
      // required this.message
      });
  MessageModel message;
  // MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: const BoxDecoration(
            color: Color(0xff373737),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 20, right: 20),
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
            ),
            Text(
              // message.message,
              message.message ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
