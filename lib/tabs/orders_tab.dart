import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/order_bloc.dart';
import 'package:mix_burguer_admin/widgets/order_tile.dart';
class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _ordersBloc = BlocProvider.of<OrdersBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: StreamBuilder<List>(
        stream: _ordersBloc.outOrders,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }else if(snapshot.data.length == 0){
            return Center(
              child: Text("Nehum Pedido encontrado!",
              style: TextStyle(color: Colors.white),),

            );

          }else{
            return ListView.builder(
              itemCount:snapshot.data.length ,
              itemBuilder: (context,index){
                return OrderTile(snapshot.data[index]);
              },

            );
          }

        }
      ),
    );
  }
}
