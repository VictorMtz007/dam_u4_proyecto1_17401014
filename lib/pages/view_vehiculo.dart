import 'package:flutter/material.dart';
import 'package:dam_u4_proyecto1_17401014/services/crud_vehiculos.dart';

class ViewVehiculo extends StatefulWidget {
  const ViewVehiculo({Key? key}) : super(key: key);

  @override
  State<ViewVehiculo> createState() => _ViewVehiculoState();
}

class _ViewVehiculoState extends State<ViewVehiculo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vehiculos"),),
      body: FutureBuilder(
          future: getVehiculos(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) async {
                      await deleteVehiculos(snapshot.data?[index]['uid']);
                    },
                    confirmDismiss: (direction) async {
                      bool result = false;
                      result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("¿Estas seguro de querer eliminar a ${snapshot.data?[index]['placa']}?"),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context, false);
                              }, child: const Text("NO, Cancelar")),
                              TextButton(onPressed: () {
                                Navigator.pop(context, true);
                              }, child: const Text("Si, Eliminar Ahora")),
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
                        await Navigator.pushNamed(context, '/editV', arguments: {
                          "placa": snapshot.data?[index]['placa'],
                          "tipo": snapshot.data?[index]['tipo'],
                          "numeroserie": snapshot.data?[index]['numeroserie'],
                          "combustible": snapshot.data?[index]['combustible'],
                          "tanque": snapshot.data?[index]['tanque'] ?? '',
                          "trabajador": snapshot.data?[index]['trabajador'],
                          "depto": snapshot.data?[index]['depto'],
                          "resguardadopor": snapshot.data?[index]['resguardadopor'],
                          "uid": snapshot.data?[index]['uid'],
                        });
                        setState(() {});
                      },
                      child: ListTile(
                        title: Text(snapshot.data?[index]['placa']),
                        subtitle: Row(
                          children: [
                            Text(
                              'Tipo: ${snapshot.data?[index]['tipo'] ?? 'No se especifica'} \n'
                              'Numero de Serie: ${snapshot.data?[index]['numeroserie'] ?? 'No se especifica'} \n'
                              'Combustible: ${snapshot.data?[index]['combustible'] ?? 'No se especifica'} \n'
                              'Tanque: ${snapshot.data?[index]['tanque'] ?? 'No se especifica'} \n'
                              'Trabajador: ${snapshot.data?[index]['trabajador'] ?? 'No se especifica'} \n'
                              'Departamento: ${snapshot.data?[index]['depto'] ?? 'No se especifica'} \n'
                              'Resguardado por: ${snapshot.data?[index]['resguardadopor'] ?? 'No se especifica'}'
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
          await Navigator.pushNamed(context, '/addV');
          setState(() {});
        }, child: const Icon(Icons.add),
      ),
    );
  }
}