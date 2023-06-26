import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductView'),
        centerTitle: true,
      ),
      body: GetBuilder<AddProductController>(
        builder: (controller) => Padding(
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
                onPressed: () => controller.addProduct(
                  controller.nameC.text,
                  controller.priceC.text,
                ),
                child: const Text("Add product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
