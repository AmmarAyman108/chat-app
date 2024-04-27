import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/register_cubit/register_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/register_cubit/register_state.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_state.dart';
import 'package:flutter_application_1/presentation/views/home_view.dart';
import 'package:flutter_application_1/presentation/widgets/center_text.dart';
import 'package:flutter_application_1/presentation/widgets/custom_button.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text_field.dart';
import 'package:flutter_application_1/presentation/widgets/end_text.dart';
import 'package:flutter_application_1/presentation/widgets/logo.dart';
import 'package:flutter_application_1/presentation/widgets/password_felid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  static String id = 'LoginView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? password, email, name;
  bool loading = false;
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          loading = true;
        } else if (state is RegisterSuccessState) {
          loading = false;
          CustomSnackBar(context, 'Success register');
        } else if (state is RegisterFailureState) {
          loading = false;
          CustomSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: loading,
            child: Form(
              autovalidateMode: autoValidateMode,
              key: key,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            if (state is InitialState ||
                                state is LightThemeState) {
                              return IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ThemeCubit>(context)
                                        .theme(context);
                                  },
                                  icon: const Icon(Icons.dark_mode));
                            } else {
                              return IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ThemeCubit>(context)
                                        .theme(context);
                                  },
                                  icon: const Icon(Icons.light_mode));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const Logo(),
                  const SizedBox(
                    height: 10,
                  ),
                  const text(
                    title: 'Register',
                    textAlign: TextAlign.center,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const text(
                    title: 'Register to continue using the app',
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const text(
                    title: 'Name',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    onChanged: (p0) => name = p0,
                    hint: 'Enter your Name',
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const text(
                    title: 'Email',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                      hint: 'Enter your Email',
                      onChanged: (val) => email = val,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  const text(
                    title: 'Password',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  PasswordFelid(
                    onChanged: (val) => password = val,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  EndText(title: 'Forget Password ? '),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      title: 'Register',
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .registerByEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                  name: name!);
                          BlocProvider.of<ChatCubit>(context).getMessage();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeView(
                                        user: email,
                                        name: name,
                                      )),
                              (Route<dynamic> route) => false);
                        } else {
                          autoValidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      }),
                  const SizedBox(
                    height: 7,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CenterText(
                    textHint: 'Don\'t have an account ? ',
                    textButton: ' Login',
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  void CustomSnackBar(context, content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }

  // Future<String?> getImage() async {
  //   File? userImageProfile;
  //   userImageProfile =
  //       await ImagePicker().pickImage(source: imagepicer.gallary);
  //   return await userImageProfile;
  // }
}
