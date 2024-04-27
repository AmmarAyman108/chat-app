import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/business_logic/cubits/register_cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
   var users = FirebaseFirestore.instance.collection('users');

  Future<void> registerByEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      users.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'email': email,
        'name': name,
        'imageUrl': '',
        'date': DateTime.now()
      });
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailureState(errorMessage: 'weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailureState(errorMessage: 'email already in use'));
      } else if (e.code == "invalid-email") {
        emit(RegisterFailureState(errorMessage: "Invalid Email."));
      }
    } catch (e) {
      emit(RegisterFailureState(errorMessage: e.toString()));
    }
  }
}
// CustomSnackBar(context, const Text('Invalid Email.'));
 