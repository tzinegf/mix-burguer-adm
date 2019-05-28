import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/login_block.dart';
import 'package:mix_burguer_admin/models/user_model.dart';
import 'package:mix_burguer_admin/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.green),
          title: Text("MIX BURGUER"),
          centerTitle: true,
        ),
        body:Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: Image.asset("assets/mix_burguer_admin.png"),
                    ),
                    InputField(
                      icon: Icons.person_outline,
                      hint: "Usuário",
                      obscure: false,
                      stream: _loginBloc.outEmail,
                      onChanged: _loginBloc.changeEmail,
                    ),
                    InputField(
                      icon: Icons.lock_outline,
                      hint: "Senha",
                      obscure: true,
                      stream: _loginBloc.outPassword,
                      onChanged: _loginBloc.changePassword,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    StreamBuilder<bool>(
                      stream: _loginBloc.outSubmitValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          height: 50,
                          child: RaisedButton(
                            onPressed: snapshot.hasData ? _loginBloc.submit: null,
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text("Entrar"),
                            disabledColor: Colors.grey,
                          ),
                        );
                      }
                    ),

                  ],
                ),
              ),
            ),
          ],

        ),
    );
  }

}
