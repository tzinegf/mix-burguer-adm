import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/order_bloc.dart';
import 'package:mix_burguer_admin/blocs/user_bloc.dart';
import 'package:mix_burguer_admin/tabs/orders_tab.dart';
import 'package:mix_burguer_admin/tabs/users_tab.dart';


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
          canvasColor: Colors.white,
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
              icon: Icon(Icons.person),
              title: Text("Clientes")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Pedidos")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Produtos")
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
                UsersTab(),
                OrdersTab(),
                Container(color: Colors.yellow,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
