import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutWrapper extends StatelessWidget {
  final Widget childWidget;

  const LayoutWrapper({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('ObjectBox Sandbox', style: TextStyle(color: Colors.white)),
      ),
      resizeToAvoidBottomInset: true,
      drawerEnableOpenDragGesture: false,
      body: LayoutBuilder(
        builder:
            (content, constraints) =>
                Container(constraints: BoxConstraints(maxWidth: Get.context!.width, maxHeight: Get.context!.height), child: childWidget),
      ),
    ),
  );
}
