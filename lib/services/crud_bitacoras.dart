import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore DB = FirebaseFirestore.instance;

Future<List> getBitacoras() async {
  List bitacoras = [];
  QuerySnapshot querySnapshot = await DB.collection('bitacoras').get();
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final bita = {
      "placa": data['placa'],
      "fecha": data['fecha'],
      "evento": data['evento'],
      "recursos": data['recursos'],
      "verifico": data['verifico'],
      "fechaverificacion": data['fechaverificacion'],
      "uid": doc.id,
    };
    bitacoras.add(bita);
  }
  await Future.delayed(const Duration(seconds: 2));
  return bitacoras;
}

Future<void> addBitacoras(
    String placa, DateTime fecha, String evento,
    String recursos, String verifico, DateTime fechaverificacion,
    ) async {
  await DB.collection('bitacoras').add(
      {
        "placa": placa,
        "fecha": fecha,
        "evento": evento,
        "recursos": recursos,
        "verifico": verifico,
        "fechaverificacion": fechaverificacion,
      }
  );
}

Future<void> updateBitacoras( String uid,
    String Nplaca, DateTime Nfecha, String Nevento,
    String Nrecursos, String Nverifico, DateTime Nfechaverificacion
    ) async {
  await DB.collection('bitacoras').doc(uid).set({
    'placa': Nplaca, 'fecha': Nfecha, 'evento': Nevento,
    'recursos': Nrecursos, 'verifico': Nverifico, 'fechaverificacion': Nfechaverificacion
  });
}