import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<UserModel>(
              model: UserModel(),
              child: MaterialApp(
                  title: "Mix Burguer ADM",
                  theme: ThemeData.dark(),
                  debugShowCheckedModeBanner: false,
                  home: LoginScreen()


              ),
            );
          }
      ),
    );
















      MaterialApp(
      title: "Mix Burguer ADM",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


