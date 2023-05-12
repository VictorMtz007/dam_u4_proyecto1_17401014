import 'package:dam_u4_proyecto1_17401014/pages/add_bitacora.dart';
import 'package:dam_u4_proyecto1_17401014/pages/add_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401014/pages/edit_bitacora.dart';
import 'package:dam_u4_proyecto1_17401014/pages/edit_vehiculo.dart';
import 'package:dam_u4_proyecto1_17401014/pages/presentacion.dart';
import 'package:dam_u4_proyecto1_17401014/pages/view_bitacora.dart';
import 'package:dam_u4_proyecto1_17401014/pages/view_vehiculo.dart';
import 'package:flutter/material.dart';
// FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CocheTec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Presentacion(),
        '/v': (context) => const ViewVehiculo(),
        '/b': (context) => const ViewBitacora(),
        '/addV': (context) => const AddVehiculo(),
        '/addB': (context) => const AddBitacora(),
        '/editV': (context) => const EditVehiculo(),
        '/editB': (context) => const EditBitacora(),
      },
    );
  }
}