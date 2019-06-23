import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/screens/product_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot _category;

  CategoryTile(this._category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      child: Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_category.data["icon"]),
            backgroundColor: Colors.transparent,
          ),
            title: Text(_category.data["title"],style: TextStyle(color: Colors.grey[850],fontWeight: FontWeight.bold),),
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
              future: _category.reference.collection("itens").getDocuments(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Container(

                  );
                }else{
                  return Column(
                    children: snapshot.data.documents.map((doc){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doc.data["image"][0]),

                        ),
                        title: Text(doc.data["title"]),
                        trailing:Text("R\$ ${doc.data["price"].toStringAsFixed(2)}"),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductScreen( _category.documentID,doc)));
                        },
                      );

                    }).toList()..add(
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.add,color:Colors.green ,),
                          ),
                          title:Text("Adicionar"),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductScreen(_category.documentID,null)));
                          },
                        )

                    ),
                  );
                }
              },
            )



          ],
        ),

      ),
    );
  }
}
