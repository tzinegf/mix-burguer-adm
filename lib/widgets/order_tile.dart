import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/widgets/order_header.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {



  final DocumentSnapshot order;
  OrderTile(this.order);



  final states = ["Aguardando aprovação","Em preparação","Em transporte","Aguardando Entrega","Entregue"];

  @override
  Widget build(BuildContext context) {


    Timestamp orderDate = order.data["dataOrder"];
    DateTime dateTeste = orderDate.toDate();
    print (dateTeste);
    String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(dateTeste);



    return Container(

      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Card(
        child: ExpansionTile(
          key: Key(order.documentID),
            initiallyExpanded: order.data["status"] != 4,
            title: Text("ID:#${order.documentID.substring(order.documentID.length -7,order.documentID.length)}"+"  Status:"+" ${states[order.data["status"]]}"+"  ${formattedDate}",style: TextStyle(color: order.data["status"] != 4 ?Colors.grey:Colors.green)),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[


                  OrderHeader(order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data["products"].map<Widget>((p){
                      return ListTile(
                        title: Text(p["product"]["title"]),
                        subtitle: Text("CAT \n"+p["category"]),
                        trailing: Text("QT:\n  "+ p["qtde"].toString()),
                        contentPadding: EdgeInsets.zero,

                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Firestore.instance.collection("users").document(order["clientId"]).collection("orders").document(order.documentID).delete();
                          order.reference.delete();
                        },
                        textColor: Colors.red,
                        child: Text("Excluir"),
                      ),
                      FlatButton(
                        onPressed: order.data["status"]>0?(){
                            order.reference.updateData({"status":order.data["status"]-1});
                          }: null,
                        textColor: Colors.grey[850],
                        child: Text("Regredir"),
                      ),
                      FlatButton(
                        onPressed:order.data["status"]<4?(){
                          order.reference.updateData({"status":order.data["status"]+1});
                        }:null,
                        textColor: Colors.green,
                        child: Text("Avançar"),
                      )
                    ],
                  )
                ],
              ),
            )
          ],

        ),
      ),
    );
  }
}
