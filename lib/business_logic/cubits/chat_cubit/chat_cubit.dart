// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/data/models/message_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  var messages = FirebaseFirestore.instance.collection('Message');
  List<MessageModel> messageList = [];
  // void sendMessage({required String message, required String email}) {
  //   emit(ChatLoadingState());
  //   try {
  //     messages.add(
  //       {
  //         'Message': message,
  //         'email': email,
  //         'date': DateTime.now(),
  //       },
  //     );
  //     emit(ChatSuccessState());
  //   } on Exception catch (e) {
  //     emit(ChatFailureState(errorMessage: e.toString()));
  //   }
  // }

  void getMessage() {
    messages.orderBy('date', descending: true).snapshots().listen(
      (event) {
        messageList.clear();
        for (var element in event.docs) {
          //add data to list to show in chat view
          // messageList.add(MessageModel.fromJson(element));
          messageList.add(MessageModel.fromJson(element.data()));
        }
        emit(ChatSuccessState());
      },
    );
  }
}
