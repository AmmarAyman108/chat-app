import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/business_logic/cubits/login_cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  Future<void> loginByEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password.') {
        emit(LoginFailureState(errorMessage: 'wrong password.'));
      } else if (e.code == "invalid-email") {
        emit(LoginFailureState(errorMessage: "Invalid Email."));
      }
    } catch (e) {
      emit(LoginFailureState(errorMessage: e.toString()));
    }
  }
}
