import 'package:dam_u4_proyecto1_17401014/pages/view_bitacora.dart';
import 'package:dam_u4_proyecto1_17401014/pages/view_vehiculo.dart';
import 'package:flutter/material.dart';

class Presentacion extends StatefulWidget {
  const Presentacion({Key? key}) : super(key: key);

  @override
  State<Presentacion> createState() => _PresentacionState();
}

int _indice = 0;
class _PresentacionState extends State<Presentacion> {

  final List<Widget> _Cambiar = [
    ViewVehiculo(),
    ViewBitacora(),
  ];

  void onTabTapped(int index) {
    setState(() { _indice = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Cambiar[_indice],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _indice,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash),
            label: 'Vehiculos'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Bitacoras'
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
      ),
    );
  }
}
