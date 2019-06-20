import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/widgets/category_tile.dart';
class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
        builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
          );
        }else{
          return ListView.builder(
              itemBuilder: (context,index){
                return CategoryTile(snapshot.data.documents[index]);

              },
            itemCount: snapshot.data.documents.length,
          );
        }
        }
    );
  }
}
