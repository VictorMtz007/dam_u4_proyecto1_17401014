import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto1_17401014/services/crud_bitacoras.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class EditBitacora extends StatefulWidget {
  const EditBitacora({Key? key}) : super(key: key);

  @override
  State<EditBitacora> createState() => _EditBitacoraState();
}

class _EditBitacoraState extends State<EditBitacora> {
  TextEditingController placaCtrl = TextEditingController();
  DateTime fechaCtrl = DateTime.now();
  TextEditingController eventoCtrl = TextEditingController();
  TextEditingController recursosCtrl = TextEditingController();
  TextEditingController verificoCtrl = TextEditingController();
  DateTime fechaVCtrl = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if (arguments.isNotEmpty) {
      placaCtrl.text = arguments['placa'];
      Timestamp fechaDB = arguments['fecha'];
      int fechaEnSeg = fechaDB.millisecondsSinceEpoch;
      DateTime fechaCtrlInt = DateTime.fromMillisecondsSinceEpoch(fechaEnSeg);
      fechaCtrl = fechaCtrlInt;
      eventoCtrl.text = arguments['evento'];
      recursosCtrl.text = arguments['recursos'];
      verificoCtrl.text = arguments['verifico'];
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Bitacora'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: placaCtrl, decoration: const InputDecoration(hintText: 'Placa:', labelText: 'Placa'), enabled: false,),
              TextField(controller: verificoCtrl, decoration: const InputDecoration(hintText: 'Verifico:', labelText: 'Verifico'), autofocus: true,),
              TextButton(onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context, initialDate: fechaVCtrl,
                  firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                );
                if (picked != null && picked != fechaVCtrl) {
                  setState(() { fechaVCtrl = picked; });
                }
              }, child: Text('Fecha: ${DateFormat.yMd().format(fechaVCtrl)}'),),
              ElevatedButton(onPressed: () async {
                await updateBitacoras( arguments['uid'],
                    placaCtrl.text, fechaCtrl, eventoCtrl.text,
                    recursosCtrl.text, verificoCtrl.text, fechaVCtrl
                ).then((_) {
                  Navigator.pop(context);
                });
              }, child: const Text("Actualizar"))
            ],
          ),
        ),
      ),
    );
  }
}
