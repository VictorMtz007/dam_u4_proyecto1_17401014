import 'package:dam_u4_proyecto1_17401014/services/crud_bitacoras.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AddBitacora extends StatefulWidget {
  const AddBitacora({Key? key}) : super(key: key);

  @override
  State<AddBitacora> createState() => _AddBitacoraState();
}

class _AddBitacoraState extends State<AddBitacora> {
  TextEditingController placaCtrl = TextEditingController();
  DateTime fechaCtrl = DateTime.now();
  TextEditingController eventoCtrl = TextEditingController();
  TextEditingController recursosCtrl = TextEditingController();
  TextEditingController verificoCtrl = TextEditingController();
  DateTime fechaVCtrl = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Bitacora'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: placaCtrl, decoration: const InputDecoration(hintText: 'Placa:', labelText: 'Placa'), autofocus: true,),
              TextButton(onPressed: () async {
                final DateTime? picked = await showDatePicker(
                    context: context, initialDate: fechaCtrl,
                    firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                );
                if (picked != null && picked != fechaCtrl) {
                  setState(() { fechaCtrl = picked; });
                }
              }, child: Text('Fecha: ${DateFormat.yMd().format(fechaCtrl)}'),),
              TextField(controller: eventoCtrl, decoration: const InputDecoration(hintText: 'Evento:', labelText: 'Evento'),),
              TextField(controller: recursosCtrl, decoration: const InputDecoration(hintText: 'Recursos:', labelText: 'Recursos'),),
              TextField(controller: verificoCtrl, decoration: const InputDecoration(hintText: 'Verifico:', labelText: 'Verifico'),),
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
                await addBitacoras(
                    placaCtrl.text, fechaCtrl, eventoCtrl.text,
                    recursosCtrl.text, verificoCtrl.text, fechaVCtrl
                ).then((_) {
                  Navigator.pop(context);
                });
              }, child: const Text("Guardar"))
            ],
          ),
        ),
      ),
    );
  }
}