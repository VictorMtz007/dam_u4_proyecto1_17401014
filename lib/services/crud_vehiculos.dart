import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore DB = FirebaseFirestore.instance;

Future<List> getVehiculos() async {
  List vehiculos = [];
  QuerySnapshot querySnapshot = await DB.collection('vehiculos').get();
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final vehicle = {
      "placa": data['placa'],
      "tipo": data['tipo'],
      "numeroserie": data['numeroserie'],
      "combustible": data['combustible'],
      "tanque": data['tanque'],
      "trabajador": data['trabajador'],
      "depto": data['depto'],
      "resguardadopor": data['resguardadopor'],
      "uid": doc.id,
    };
    vehiculos.add(vehicle);
  }
  await Future.delayed(const Duration(seconds: 2));
  return vehiculos;
}

Future<void> addVehiculos(
    String placa, String tipo, String numeroserie, String combustible,
    int tanque, String trabajador, String depto, String resguardadopor
  ) async {
  await DB.collection('vehiculos').add(
      {
        "placa": placa,
        "tipo": tipo,
        "numeroserie": numeroserie,
        "combustible": combustible,
        "tanque": tanque,
        "trabajador": trabajador,
        "depto": depto,
        "resguardadopor": resguardadopor,
      }
  );
}

Future<void> updateVehiculos( String uid,
    String Nplaca, String Ntipo, String Nnumeroserie, String Ncombustible,
    int Ntanque, String Ntrabajador, String Ndepto, String Nresguardadopor
  ) async {
  await DB.collection('vehiculos').doc(uid).set({
    'placa': Nplaca, 'tipo': Ntipo, 'numeroserie': Nnumeroserie, 'combustible': Ncombustible,
    'tanque': Ntanque, 'trabajador': Ntrabajador, 'depto': Ndepto, 'resguardadopor': Nresguardadopor
  });
}

Future<void> deleteVehiculos( String uid ) async {
  await DB.collection('vehiculos').doc(uid).delete();
}