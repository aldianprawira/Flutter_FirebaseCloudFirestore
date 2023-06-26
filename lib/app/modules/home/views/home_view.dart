import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var listAllDocs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: listAllDocs.length,
                itemBuilder: (context, index) {
                  // * filter harga
                  if ((listAllDocs[index].data() as Map<String, dynamic>)["Price"] > 50000) {
                    return ListTile(
                      onTap: () => Get.toNamed(
                        Routes.EDIT_PRODUCT,
                        arguments: listAllDocs[index].id,
                      ),
                      leading: const Icon(Icons.monetization_on, color: Colors.red),
                      trailing: IconButton(
                        onPressed: () => controller.deleteProduct(listAllDocs[index].id),
                        icon: const Icon(Icons.delete),
                      ),
                      // * diubah bentuknya dari objek ke mapping
                      title: Text("${(listAllDocs[index].data() as Map<String, dynamic>)["Name"]}"),
                      subtitle: Text("Rp${(listAllDocs[index].data() as Map<String, dynamic>)["Price"]}"),
                    );
                  } else {
                    return ListTile(
                      onTap: () => Get.toNamed(
                        Routes.EDIT_PRODUCT,
                        arguments: listAllDocs[index].id,
                      ),
                      leading: const Icon(Icons.monetization_on, color: Colors.green),
                      trailing: IconButton(
                        onPressed: () => controller.deleteProduct(listAllDocs[index].id),
                        icon: const Icon(Icons.delete),
                      ),
                      // * diubah bentuknya dari objek ke mapping
                      title: Text("${(listAllDocs[index].data() as Map<String, dynamic>)["Name"]}"),
                      subtitle: Text("Rp${(listAllDocs[index].data() as Map<String, dynamic>)["Price"]}"),
                    );
                  }
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
        child: const Icon(Icons.add),
      ),
    );
  }
}
