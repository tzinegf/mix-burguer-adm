import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {
  DocumentSnapshot order;

  OrderHeader(this.order);

  @override
  Widget build(BuildContext context) {
    final _userBloc = BlocProvider.of<UserBloc>(context);
final _user =_userBloc.getUser(order.data["clientId"]);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${_user["name"]}"),
              Text("${_user["address"]}"+"Nº: "+ "${_user["number"]}"),
              Text("${_user["neighborhood"]}"),

            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Frete: R\$${order.data["shipPrice"].toStringAsFixed(2)}"),
            Text("Total: R\$${order.data["totalPrice"].toStringAsFixed(2)}"),

          ],
        )
      ],


    );
  }
}
