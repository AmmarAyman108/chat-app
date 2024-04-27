import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());
  var messages = FirebaseFirestore.instance.collection('Message');

  void sendMessage({required String message, required String email}) {
    emit(SendMessageLoading());
    try {
      messages.add({
        'Message': message, // John Doe
        'email': email, // Stokes and Sons
        'date': DateTime.now(), // 42
      });
      emit(SendMessageSuccess());
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      emit(SendMessageFailure());
    }
  }
}
