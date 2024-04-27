// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatFailureState extends ChatState {
  String errorMessage;
  ChatFailureState({
    required this.errorMessage,
  }); 
}
class ChatSuccessState extends ChatState {}
