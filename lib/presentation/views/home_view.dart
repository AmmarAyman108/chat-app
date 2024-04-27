import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constant.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_application_1/business_logic/cubits/theme_cubit/theme_state.dart';
import 'package:flutter_application_1/presentation/widgets/list_tile_item.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  HomeView({super.key, this.user, this.name});
  String? user, name;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.orderBy('date').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          if (state is InitialState ||
                              state is LightThemeState) {
                            return IconButton(
                              onPressed: () {
                                BlocProvider.of<ThemeCubit>(context)
                                    .theme(context);
                              },
                              icon: const Icon(
                                Icons.dark_mode,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            return IconButton(
                              onPressed: () {
                                BlocProvider.of<ThemeCubit>(context)
                                    .theme(context);
                              },
                              icon: const Icon(
                                Icons.light_mode,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                  automaticallyImplyLeading: false,
                  title: const text(
                      title: 'Scholar Chat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 23),
                  backgroundColor: CustomColor.kColor,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => ListTileItem(
                            name: snapshot.data!.docs[index]['name'],
                            email: snapshot.data!.docs[index]['email'],
                          )),
                ));
          } else {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
