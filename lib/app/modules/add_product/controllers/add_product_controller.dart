import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // * late digunakan untuk memaksa kita untuk melakukan inisialisasi
  late TextEditingController nameC = TextEditingController();
  late TextEditingController priceC = TextEditingController();

  void addProduct(String name, String price) async {
    CollectionReference products = firestore.collection("products");
    try {
      String time = DateTime.now().toIso8601String();
      await products.add({
        "Name": name,
        "Price": int.parse(price),
        "Time": time,
      });

      Get.defaultDialog(
        title: "Succeed",
        middleText: "Product added successfully",
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
        middleText: "Product failed to add",
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
