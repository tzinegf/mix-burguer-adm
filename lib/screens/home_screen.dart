import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _controller;
  int _page = 0;


  @override
  void initState() {
    super.initState();
    _controller = PageController();
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
      body: PageView(
        controller: _controller,
        onPageChanged: (p){
          setState(() {
            _page = p;
          });
        },
        children: <Widget>[
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          Container(color: Colors.yellow,),
        ],
      ),
    );
  }
}
