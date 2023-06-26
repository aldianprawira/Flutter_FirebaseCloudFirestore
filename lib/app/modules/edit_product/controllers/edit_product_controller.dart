import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // * late digunakan untuk memaksa kita untuk melakukan inisialisasi
  late TextEditingController nameC = TextEditingController();
  late TextEditingController priceC = TextEditingController();

  // * one-time read untuk ditampilkan di textfield halaman edit product
  Future<DocumentSnapshot<Object?>> getData(String docID) {
    DocumentReference docRef = firestore.collection("products").doc(docID);
    return docRef.get();
  }

  void editProduct(String name, String price, String docID) async {
    DocumentReference docData = firestore.collection("products").doc(docID);
    try {
      await docData.update({
        "Name": name,
        "Price": int.parse(price),
      });
      Get.defaultDialog(
        title: "Succeed",
        middleText: "Product edited successfully",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "Okay",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Something went wrong",
        middleText: "Product failed to edit",
        onConfirm: () => Get.back(),
        textConfirm: "Okay",
      );
    }
  }

  // * inisialisasi dari variabel nameC dan priceC
  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  // * agar tidak terjadi kebocoran memori
  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    super.onClose();
  }
}
