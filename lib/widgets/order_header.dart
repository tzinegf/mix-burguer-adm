import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {
  DocumentSnapshot order;
  GlobalKey key;

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
            Text(order.data["payMode"]?"Pagamento: Dinheiro":"Pagamento: Cartão"),
            Text(order.data["payMode"]?"Valor: R\$${order.data["valoPTroco"].toStringAsFixed(2)}":""),
            Text(order.data["payMode"]?"Troco: R\$${order.data["troco"].toStringAsFixed(2)}":""),
            Text("Total: R\$${order.data["totalPrice"].toStringAsFixed(2)}"),
          ],
        )
      ],


    );
  }
}
