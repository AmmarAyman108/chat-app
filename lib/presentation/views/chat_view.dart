import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/send_message/send_message_cubit.dart';
import 'package:flutter_application_1/constants/constant.dart';
import 'package:flutter_application_1/data/models/message_model.dart';
import 'package:flutter_application_1/presentation/widgets/back.dart';
import 'package:flutter_application_1/presentation/widgets/chat_buble.dart';
import 'package:flutter_application_1/presentation/widgets/chat_buble_other.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  ChatView({super.key, this.email, required this.name});
  String? email;
  String name;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  FocusNode focusNode = FocusNode();

  TextEditingController controller = TextEditingController();

  // ignore: non_constant_identifier_names
  var Message = FirebaseFirestore.instance.collection('Message');

  final ScrollController scrollController = ScrollController();

  String? message;
  List<MessageModel> messageList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: CustomColor.kColor,
            height: 89,
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Back(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5000),
                        image: const DecorationImage(
                            image: AssetImage('assets/xm.jpg'),
                            fit: BoxFit.fill)),
                  ),
                ),
                text(
                    title: widget.name,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccessState) {
                    messageList =
                        BlocProvider.of<ChatCubit>(context).messageList;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      controller: scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) =>
                          messageList[index].email == widget.email
                              ? ChatBuble(
                                  message: messageList[index],
                                )
                              : ChatBubleOther(message: messageList[index]));
                },
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 5, top: 4),
            child: Row(children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(right: 5, left: 2),
                    child: CustomTextField(
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context).requestFocus(focusNode);
                      },
                      onChanged: (p0) => message = p0,
                      controller: controller,
                      focusNode: focusNode,
                      hint: 'Message',
                      icon: Icons.face,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      color: CustomColor.kColor),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          BlocProvider.of<SendMessageCubit>(context)
                              .sendMessage(
                                  message: message!, email: widget.email!);
                          controller.clear();
                          focusNode.requestFocus();
                          scrollController.animateTo(0,
                              duration: const Duration(seconds: 3),
                              curve: Curves.easeIn);
                        },
                        icon: const Icon(
                          Icons.send,
                          size: 25,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
