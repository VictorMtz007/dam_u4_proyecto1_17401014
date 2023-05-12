import 'package:dam_u4_proyecto1_17401014/services/crud_vehiculos.dart';
import 'package:flutter/material.dart';

class AddVehiculo extends StatefulWidget {
  const AddVehiculo({Key? key}) : super(key: key);

  @override
  State<AddVehiculo> createState() => _AddVehiculoState();
}

class _AddVehiculoState extends State<AddVehiculo> {
  TextEditingController placaCtrl = TextEditingController();
  TextEditingController tipoCtrl = TextEditingController();
  TextEditingController nSerieCtrl = TextEditingController();
  TextEditingController combCtrl = TextEditingController();
  TextEditingController tanqueCtrl = TextEditingController();
  TextEditingController trabCtrl = TextEditingController();
  TextEditingController deptoCtrl = TextEditingController();
  TextEditingController resPorCtrl = TextEditingController();
  String? tipoV;
  String? tipoC;
  String? tipoD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Vehiculo'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: placaCtrl, decoration: const InputDecoration(hintText: 'Placa:', labelText: 'Placa'), autofocus: true,),
              DropdownButtonFormField<String>(
                  value: tipoV, decoration: InputDecoration(labelText: "Seleccione un Tipo"),
                  items: <String>['CAMION','COCHE','CAMIONETA','TRACKTOR','MOTOCICLETA'].map((String value) {
                    return DropdownMenuItem<String>(value:value,child: Text(value),);
                  }).toList(), onChanged: (newValue){
                setState(() {tipoV = newValue;});
              }),
              TextField(controller: nSerieCtrl, decoration: const InputDecoration(hintText: 'Num. de Serie:', labelText: 'Num. de Serie'),),
              DropdownButtonFormField<String>(
                  value: tipoC, decoration: InputDecoration(labelText: "Seleccione el Combustible"),
                  items: <String>['Disel','Gas. Regular','Premium'].map((String value) {
                    return DropdownMenuItem<String>(value:value,child: Text(value),);
                  }).toList(), onChanged: (newValue){
                setState(() {tipoC = newValue;});
              }),
              TextField(controller: tanqueCtrl, decoration: const InputDecoration(hintText: 'Tanque:', labelText: 'Tanque'),),
              TextField(controller: trabCtrl, decoration: const InputDecoration(hintText: 'Trabajador:', labelText: 'Trabajador'),),
              DropdownButtonFormField<String>(
                  value: tipoD, decoration: InputDecoration(labelText: "Seleccione un Departamento"),
                  items: <String>['Materiales','Jardineria','Direccion','Seguridad','Otro'].map((String value) {
                    return DropdownMenuItem<String>(value:value,child: Text(value),);
                  }).toList(), onChanged: (newValue){
                setState(() {tipoD = newValue;});
              }),
              TextField(controller: resPorCtrl, decoration: const InputDecoration(hintText: 'Resguadado por:', labelText: 'Resguardado por'),),
              ElevatedButton(onPressed: () async {
                await addVehiculos(
                  placaCtrl.text, tipoV!, nSerieCtrl.text, tipoC!,
                  int.parse(tanqueCtrl.text), trabCtrl.text, tipoD!, resPorCtrl.text
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
