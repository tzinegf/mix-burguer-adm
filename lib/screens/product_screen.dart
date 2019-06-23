import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_admin/blocs/product_bloc.dart';
import 'package:mix_burguer_admin/validators/product_validator.dart';
import 'package:mix_burguer_admin/widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductScreen(this.categoryId, this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product, categoryId);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {
  final _formKey = GlobalKey<FormState>();
  final ProductBloc _productBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProductScreenState(DocumentSnapshot product, String categoryId)
      : _productBloc = ProductBloc(product, categoryId);

  @override
  Widget build(BuildContext context) {
    final fildStyle = TextStyle(color: Colors.white, fontSize: 16);
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.grey));
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(snapshot.data ? "Editar Produto" : "Criar Produto");
            }),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context,snapshot){
              if(snapshot.data)
                return StreamBuilder<bool>(
                    stream: _productBloc.outLoanding,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: snapshot.data ? null : (){
                          _productBloc.deleteProduct();
                          Navigator.of(context).pop();

                        },
                      );
                    });
              else return Container();
            },
          ),

          StreamBuilder<bool>(
              stream: _productBloc.outLoanding,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(Icons.save),
                  onPressed: snapshot.data ? null : saveProduct,
                );
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Form(
              key: _formKey,
              child: StreamBuilder<Map>(
                  stream: _productBloc.outData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      return ListView(
                        padding: EdgeInsets.all(16),
                        children: <Widget>[
                          Text(
                            "Imagens",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          ImagesWidget(
                            context: context,
                            initialValue: snapshot.data["image"],
                            onSaved: _productBloc.saveListImages,
                            validator: validateImages,
                          ),
                          TextFormField(
                            initialValue: snapshot.data["title"],
                            style: fildStyle,
                            decoration: _buildDecoration("Titulo"),
                            onSaved: _productBloc.saveTitle,
                            validator: validateTitle,
                          ),
                          TextFormField(
                            initialValue: snapshot.data["description"],
                            style: fildStyle,
                            maxLines: 6,
                            decoration: _buildDecoration("Descrição"),
                            onSaved: _productBloc.saveDescription,
                            validator: validateDescription,
                          ),
                          TextFormField(
                            initialValue:
                                snapshot.data["price"]?.toStringAsFixed(2),
                            style: fildStyle,
                            decoration: _buildDecoration("Preço"),
                            onSaved: _productBloc.savePrice,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            validator: validatePrice,
                          )
                        ],
                      );
                    }
                  })),
          StreamBuilder<bool>(
              stream: _productBloc.outLoanding,
              initialData: false,
              builder: (context, snapshot) {
                return IgnorePointer(
                  ignoring: !snapshot.data,
                  child: Container(
                    color: snapshot.data ? Colors.black54 : Colors.transparent,
                  ),
                );
              })
        ],
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Salvando produto...",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
        backgroundColor: Colors.yellow,
      ));
      bool success = await _productBloc.saveProduct();
      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success ? "Produto salvo!" : "Erro ao salvar o produto!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: success ? Colors.green : Colors.red,
      ));
    }
  }
}
