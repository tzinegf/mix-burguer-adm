import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  Stream<Map> get outData => _dataController.stream;

  Stream<bool> get outLoanding => _loadingController.stream;

  Stream<bool> get outCreated => _createdController.stream;

  String categoryId;
  DocumentSnapshot product;
  Map<String, dynamic> unsavedData;

  ProductBloc(this.product, this.categoryId) {
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData["image"] = List.of(product.data["image"]);
      _createdController.add(true);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "image": [],
      };
      _createdController.add(false);
    }
    _dataController.add(unsavedData);
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveDescription(String description) {
    unsavedData["description"] = description;
  }

  void savePrice(String price) {
    unsavedData["price"] = double.parse(price);
  }

  void saveListImages(List images) {
    unsavedData["image"] = images;
  }
  void deleteProduct(){
    product.reference.delete();
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);
    try {
      if (product != null) {
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsavedData);
      } else {
        DocumentReference dr = await Firestore.instance
            .collection("products")
            .document(categoryId)
            .collection("itens")
            .add(Map.from(unsavedData)..remove("image"));
        await _uploadImages(dr.documentID);
        await dr.updateData(unsavedData);
      }
      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  Future _uploadImages(String producId) async {
    for (int i = 0; i < unsavedData["image"].length; i++) {
      if (unsavedData["image"][i] is String) continue;

      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(producId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(unsavedData["image"][i]);
      StorageTaskSnapshot s = await uploadTask.onComplete;
      String downloadUrl = await s.ref.getDownloadURL();
      unsavedData["image"][i] = downloadUrl;
    }
  }

  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }
}
