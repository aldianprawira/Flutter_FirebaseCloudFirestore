import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() {
    CollectionReference products = firestore.collection("products");
    return products.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection("products");
    // ! filter hanya bisa dilakukan sekali
    // * filter bedasarkan price
    // return products.where("Price", isGreaterThan: 50000).snapshots();
    // * filter bedasarkan time added
    return products.orderBy("Time", descending: true).snapshots();
  }

  void deleteProduct(String docID) {
    DocumentReference docRef = firestore.collection("products").doc(docID);
    try {
      Get.defaultDialog(
        title: "Delete confirmation",
        middleText: "Are you sure want to delete",
        onConfirm: () async {
          await docRef.delete();
          Get.back();
        },
        textConfirm: "Yes",
        textCancel: "No",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Something went wrong",
        middleText: "Product failed to delete",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
      );
    }
  }
}
