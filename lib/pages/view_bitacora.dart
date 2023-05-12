import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_17401014/services/crud_bitacoras.dart';

class ViewBitacora extends StatefulWidget {
  const ViewBitacora({Key? key}) : super(key: key);

  @override
  State<ViewBitacora> createState() => _ViewBitacoraState();
}

class _ViewBitacoraState extends State<ViewBitacora> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bitacoras"),),
      body: FutureBuilder(
          future: getBitacoras(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    confirmDismiss: (direction) async {
                      bool result = false;
                      result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Por terminos de seguridad es imposible eliminar a ${snapshot.data?[index]['placa']}"),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context, false);
                                }, child: const Text("Volver")),
                              ],
                            );
                          }
                      );
                      return result;
                    },
                    background: Container(
                        child: const Icon(Icons.delete),
                        color: Colors.red
                    ),
                    key: Key(snapshot.data?[index]['uid']),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.pushNamed(context, '/editB', arguments: {
                          "placa": snapshot.data?[index]['placa'],
                          "fecha": snapshot.data?[index]['fecha'] ?? '',
                          "evento": snapshot.data?[index]['evento'],
                          "recursos": snapshot.data?[index]['recursos'],
                          "verifico": snapshot.data?[index]['verifico'],
                          "fechaverificacion": snapshot.data?[index]['fechaverificacion'] ?? '',
                          "uid": snapshot.data?[index]['uid'],
                        });
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(snapshot.data?[index]['placa']),
                        subtitle: Row(
                          children: [
                            Text(
                              'Fecha: ${(snapshot.data?[index]['fecha'] as Timestamp).toDate().toString() ?? 'No se especifica'} \n'
                              'Evento: ${snapshot.data?[index]['evento'] ?? 'No se especifica'} \n'
                              'Recursos: ${snapshot.data?[index]['recursos'] ?? 'No se especifica'} \n'
                              'Verifico: ${snapshot.data?[index]['verifico'] ?? 'No se especifica'} \n'
                              'Fecha de Verificacion: ${(snapshot.data?[index]['fechaverificacion'] as Timestamp).toDate().toString() ?? 'No se especifica'}'
                            ),
                          ],
                        ),
                        //trailing: Text(snapshot.data?[index]['uid']),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/addB');
          setState(() {});
        }, child: const Icon(Icons.add),
      ),
    );
  }
}