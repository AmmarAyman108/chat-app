import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logic/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/login_cubit/login_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/login_cubit/login_state.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_state.dart';
import 'package:flutter_application_1/presentation/views/home_view.dart';
import 'package:flutter_application_1/presentation/views/register.dart';
import 'package:flutter_application_1/presentation/widgets/center_text.dart';
import 'package:flutter_application_1/presentation/widgets/custom_button.dart';
import 'package:flutter_application_1/presentation/widgets/custom_circle.dart';
import 'package:flutter_application_1/presentation/widgets/custom_divider.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text_field.dart';
import 'package:flutter_application_1/presentation/widgets/end_text.dart';
import 'package:flutter_application_1/presentation/widgets/logo.dart';
import 'package:flutter_application_1/presentation/widgets/password_felid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading = false;
  String? password, email;
  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          loading = true;
        } else if (state is LoginSuccessState) {
          loading = false;
          CustomSnackBar(context, 'Success login');
        } else if (state is LoginFailureState) {
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
                              icon: const Icon(Icons.dark_mode),
                            );
                          } else {
                            return IconButton(
                              onPressed: () {
                                BlocProvider.of<ThemeCubit>(context)
                                    .theme(context);
                              },
                              icon: const Icon(Icons.light_mode),
                            );
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
                  title: 'Login',
                  textAlign: TextAlign.center,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 30,
                ),
                const text(
                  title: 'Login to continue using the app',
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 10,
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
                    onChanged: (p0) => email = p0,
                    hint: 'Enter your Email',
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
                  onChanged: (p0) => password = p0,
                ),
                const SizedBox(
                  height: 5,
                ),
                EndText(title: 'Forget Password ? '),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  title: 'Login',
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context)
                          .loginByEmailAndPassword(
                              email: email!, password: password!);
                                                        BlocProvider.of<ChatCubit>(context).getMessage();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomeView(
                                    user: email,
                                  )),
                          (Route<dynamic> route) => false);
                    } else {
                      autoValidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 7,
                ),
                const CustomDivider(),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    CustomCircle(
                        image: 'assets/fb_1695273515215_1695273522698.avif'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomCircle(
                        onTap: () {},
                        image: 'assets/Screenshot 2023-11-08 043822.png'),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomCircle(
                        image: 'assets/Picsart_23-11-08_07-35-49-889.jpg'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CenterText(
                    textHint: 'Don\'t have an account ? ',
                    textButton: ' Register',
                    onTap: () => Navigator.pushNamed(context, RegisterView.id)),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
  // ignore: non_constant_identifier_names
  void CustomSnackBar(context, content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }
}
