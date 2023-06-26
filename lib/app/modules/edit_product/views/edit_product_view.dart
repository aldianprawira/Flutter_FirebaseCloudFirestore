import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends StatelessWidget {
  const EditProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditProductView'),
        centerTitle: true,
      ),
      body: GetBuilder<EditProductController>(
        builder: (controller) => FutureBuilder<DocumentSnapshot<Object?>>(
          // * isi argumennya adalah ID suatu record
          future: controller.getData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // * data adalah record dengan ID tertentu
              var data = snapshot.data!.data() as Map<String, dynamic>;
              controller.nameC.text = data["Name"];
              controller.priceC.text = data["Price"].toString();
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.nameC,
                      decoration: const InputDecoration(
                        label: Text("Product name"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.priceC,
                      decoration: const InputDecoration(
                        label: Text("Product price"),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => controller.editProduct(
                        controller.nameC.text,
                        controller.priceC.text,
                        Get.arguments,
                      ),
                      child: const Text("Edit product"),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
