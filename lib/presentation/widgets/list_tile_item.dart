import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_application_1/presentation/views/chat_view.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ListTileItem extends StatelessWidget {
  ListTileItem({super.key, required this.name, required this.email});
  String email, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
      child: ListTile(
        onTap: () {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChatView(
                email: email,
                name: name,
              );
            },
          ));
        },
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5000),
              image: const DecorationImage(
                  image: AssetImage('assets/xm.jpg'), fit: BoxFit.fill)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        title: text(
          title: name,
          fontSize: 19,
        ),
      ),
    );
  }
}

//import 'package:just_audio/just_audio.dart';