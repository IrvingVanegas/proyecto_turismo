import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:proyectotmp/barra_inferior/barrainf.dart' as barra;

class Reservas extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _Reservas();
  }
}

class _Reservas extends State<Reservas> {
  final _folioInputTextController =  TextEditingController();
  late List reservaciones = [];
  late List data=[];

  var desc = barra.desc;
  var buscar = barra.buscar.text;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20, top:5, bottom: 20),
            child: const Text(
              "Busca tu viaje",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 13, right: 13),
            margin: const EdgeInsets.only(left: 20, right: 20, top:5, bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(93, 93, 93, 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: _folioInputTextController,
              decoration: const InputDecoration(
                hintText: 'Ingresa tu numero de reserva',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            width: Theme.of(context).textTheme.bodyText1!.fontSize! * 24,
            margin: const EdgeInsets.only(left:6, right: 0, top: 10, bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                primary: Colors.red,
                onPrimary: Colors.white,
                // side: BorderSide(color: Colors.red, width: 1),
              ),
              onPressed: (){
                setState(() {
                  var folio = _folioInputTextController.value.text;
                  searchFolio( folio );
                });
              },
              child: const Text(
                'Buscar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchFolio (id) async{

    var identificador = id.toString();
    late List reservaciones = [];

    var url = Uri.parse('http://localhost:4000/reservas/Folio/');
    var response = await http.post(url, body: {'id': '$identificador'});

    if(json.decode(response.body)['row'].toString() != 'null'){
      reservaciones = List<Map<String, dynamic>>.from(json.decode(response.body)['row']);
    }

     if(reservaciones.isNotEmpty){
       var confirmado = reservaciones[0]["confirmado"];
       String estatus = "";

       if(confirmado == 1){
         estatus = "Activo";
       }else{
         estatus = "Cancelado";
       }

       Navigator.of(context).push(
         MaterialPageRoute(builder: (context){
           return Scaffold(
             appBar: AppBar(
                 title: const Text('Tu Reservacion', style: TextStyle(color: Colors.black),),
                 backgroundColor: Colors.white,
                 //centerTitle: true,
                 iconTheme: const IconThemeData(color: Colors.black)
             ),
             body: Container(
               child: ListView(
                 children: <Widget>[
                     Container(
                       margin: const EdgeInsets.only(left:16, top: 30, bottom: 30, right: 10),
                       child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget> [
                             Container(
                               child: Text(
                                 "Reservacion: ${reservaciones[0]["servicio"].toString()}",
                                 style: const TextStyle(
                                     fontSize: 30,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black54
                                 ),
                               ),
                             ),
                             Container(
                               child: Text(
                                 "Fecha de llegada: ${reservaciones[0]["FechaEntrada"].toString()}",
                                 style: const TextStyle(
                                     fontSize: 30,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black54
                                 ),
                               ),
                             ),
                             Container(
                               child: Text(
                                 "Fecha de partida: ${reservaciones[0]["FechaSalida"].toString()}",
                                 style: const TextStyle(
                                     fontSize: 30,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black54
                                 ),
                               ),
                             ),
                             Container(
                               child: Text(
                                 "Costo: ${reservaciones[0]["CostoTotal"].toString()}",
                                 style: const TextStyle(
                                     fontSize: 30,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black54
                                 ),
                               ),
                             ),
                             Container(
                               child: Text(
                                 "Cantidad de Personas: ${reservaciones[0]["CantPersonas"].toString()}",
                                 style: const TextStyle(
                                     fontSize: 30,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black54
                                 ),
                               ),
                             ),
                             Container(
                               child: Text(
                                 "Estatus: ${estatus}",
                                 style: const TextStyle(
                                     fontSize: 30,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black54
                                 ),
                               ),
                             ),
                           ]
                       ),
                     ),
                 ],
               ),
             ),
           );
         })
       );

     }else{
       showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           title: Text("Folio incorrecto o inexistente", style: Theme.of(context).textTheme.headline6),
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
}
