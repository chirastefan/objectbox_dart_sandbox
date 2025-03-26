import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:objectbox_dart_sandbox/objectbox.dart';
import 'package:objectbox_dart_sandbox/routes.dart';
import 'package:objectbox_dart_sandbox/screens/testing.dart';
import 'package:objectbox_dart_sandbox/widgets/layout_wrapper.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ObjectBox sandbox',
      home: LayoutWrapper(childWidget: Testing()),
      onGenerateRoute: (settings) => generateRoute(settings: settings),
    );
  }
}
