import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/order_bloc.dart';
import 'package:mix_burguer_admin/blocs/user_bloc.dart';
import 'package:mix_burguer_admin/tabs/config_tab.dart';
import 'package:mix_burguer_admin/tabs/orders_tab.dart';
import 'package:mix_burguer_admin/tabs/products_tab.dart';
import 'package:mix_burguer_admin/tabs/users_tab.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _controller;
  int _page = 0;
  UserBloc _userBloc;
  OrdersBloc _ordersBloc;


  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black54,
          primaryColor: Colors.black87,
          accentColor: Colors.red,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.black)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: _page,

            onTap:(p){
              _controller.animateToPage(p, duration: Duration(milliseconds:500 ), curve: Curves.ease);
            },
            items: [

          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Pedidos")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Produtos")
          ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Clientes")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text("Configurações")
              ),
        ]
        ),
      ),
      body: SafeArea(
        child: BlocProvider<UserBloc>(
          bloc: _userBloc,
          child: BlocProvider<OrdersBloc>(
            bloc: _ordersBloc,
            child: PageView(
              controller: _controller,
              onPageChanged: (p){
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[

                OrdersTab(),
                ProductsTab(),
                UsersTab(),
                ConfigTab(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildFloating(){
    switch(_page){
      case 2:
        return null;
        break;
      case 1:
        return null;
        break;
      case 0:
        return SpeedDial(
          child:Icon(Icons.sort) ,
          backgroundColor: Colors.red,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
                child: Icon(Icons.update,color: Colors.black),
                backgroundColor: Colors.yellow,
                label: "Por Data",
                labelStyle: TextStyle(fontSize:14,color: Colors.black),
                onTap: (){
                  _ordersBloc.setOrderCriteria(SortCriteria.READY_DATE);
                }
            ),
            SpeedDialChild(
              child: Icon(Icons.arrow_downward,color: Colors.black),
              backgroundColor: Colors.yellow,
              label: "Concluidos Abaixo",
              labelStyle: TextStyle(fontSize:14,color: Colors.black),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              }
            ),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward,color: Colors.black),
                backgroundColor: Colors.yellow,
                label: "Concluidos Acima",
                labelStyle: TextStyle(fontSize:14,color: Colors.black ),
                onTap: (){
                  _ordersBloc.setOrderCriteria(SortCriteria.READY_FIRST);
                }
            )
          ],

        );


    }

  }
}
