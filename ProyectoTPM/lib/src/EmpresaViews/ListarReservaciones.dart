import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyectotmp/barra_inferior/barrainf.dart' as barra;

class ListarReservaciones extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ListarReservaciones();
  }
}

class _ListarReservaciones extends State<ListarReservaciones> {
  late List ServiciosData = [];
  late List reservaciones = [];
  var idUser = barra.idUser;

  //obtenemos los datos de la api
  getReservas() async {
    var identificador = idUser.toString();

    var url = Uri.parse('http://localhost:4000/reservas/Empresa/');
    var response = await http.post(url, body: {'id': '$identificador'});

    if(json.decode(response.body)['row'].toString() != 'null'){
      reservaciones = List<Map<String, dynamic>>.from(json.decode(response.body)['row']);
    }

    setState(() {
      ServiciosData.addAll(reservaciones);
    });
  }

  //constructor tara inicializar el getFavoritos
  @override
  void initState() {
    super.initState();
    getReservas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top:25 ,bottom: 10,right: 10, left: 10),
              alignment: Alignment.bottomLeft,
              child: const Text(
                "Reservas",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ServiciosData.isEmpty ? DataTableNull() :  DataTableWithData(),
            ),
          ],
        ),
      ),
    );
  }

  DataTableNull(){
    return Container(
      margin: const EdgeInsets.only(top:50),
      alignment: Alignment.center,
      child: const Text(
        "Sin Datos Registrados",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  DataTableWithData(){
    return  DataTable(

      columns: const <DataColumn>[
        DataColumn(
          label: Text('Nombre'),
        ),
        DataColumn(
          label: Text('Fecha Entrada'),
        ),
        DataColumn(
          label: Text('Fecha Salida'),
        ),
        DataColumn(
          label: Text('Acciones'),
        ),
      ],
      rows: List<DataRow>.generate(
        ServiciosData == null ? 0 : ServiciosData.length,
            (int index) => DataRow(
          cells: <DataCell>[
            DataCell(Text(ServiciosData[index]["servicio"].toString())),
            DataCell(Text(ServiciosData[index]["FechaEntrada"].toString())),
            DataCell(Text(ServiciosData[index]["FechaSalida"].toString())),
            DataCell(
                Row(
                  children: <Widget>[
                    IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: (){
                          eliminar(index);
                          setState(() {
                            ServiciosData.removeAt(index);
                          });
                        },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }

  eliminar(index) async{
    var id = ServiciosData[index]["idReserva"];
    var url = Uri.parse('http://localhost:4000/reservas/eliminar/');
    var response = await http.post(url, body: {'id': '$id'});
    if (json.decode(response.body)['row'] != 'null') {
      reservaciones =
      List<Map<String, dynamic>>.from(json.decode(response.body)['row']);
    }
    getReservas();

    alerta("Reserva eliminada");
  }

  alerta(mensaje){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(mensaje, style: Theme.of(context).textTheme.headline6),
        actions: <Widget>[
          TextButton(
            child: const Text('Volver'),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
        ],
      );
    });
  }
}