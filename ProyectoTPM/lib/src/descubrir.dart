import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../barra_inferior/barrainf.dart' as barra;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Descubrir extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _Descubrir();
  }
}

class _Descubrir extends State<Descubrir> {

  late List ServiciosData = [];
  late List ServiciosData2 = [];
  late List ServiciosH = [];
  late List ServiciosV = [];
  late List ServiciosR = [];
  late List ServiciosT = [];
  late List ServiciosP = [];
  late List reservaciones = [];
  final _fechaEntradaInputTextController = TextEditingController();
  final _fechaSalidaInputTextController = TextEditingController();
  final _costoNetoInputTextController = TextEditingController();
  final _costoTotalInputTextController = TextEditingController();
  var _idEmpresa=0;
  final _personasInputTextController = TextEditingController();

  void _sendControllers(idUsuario){
    _updateControllers(idUsuario);
  }

  void _updateControllers(idUsuario){
    var controllers = [
      _idEmpresa=idUsuario,
      _fechaEntradaInputTextController.value.text,
      _fechaSalidaInputTextController.value.text,
      _costoNetoInputTextController.value.text,
      _costoTotalInputTextController.value.text,
      _personasInputTextController.value.text,
    ];
    agregarReserva(controllers);
  }

  void agregarReserva(controllers) async {
    var idUsuario = controllers[0];
    var FechaEntrada = controllers[1];
    var FechaSalida = controllers[2];
    var costoNeto = controllers[3].toString().substring(1);
    var costoTotal = controllers[4].toString().substring(1);
    var Personas = controllers[5];
    var confirmado = 1.toString();

    //var urlReserva = Uri.parse('http://10.0.2.2:4000/Agregar/Reserva');

    var urlReserva = Uri.parse('http://localhost:4000/Agregar/Reserva/');

    late List reservas = [];
    var response;

    if(_verifyData(FechaEntrada,FechaSalida,costoNeto,costoTotal,context)){
      try{

        if(idUsuario != ''){
          response = await http.post(urlReserva, body: {
            'fechaEntrada': '$FechaEntrada',
            'fechaSalida': '$FechaSalida',
            'costoTotal': '$costoTotal',
            'CantPersonas': '$Personas',
            'confirmado': '$confirmado',
            'idUsuario': '$idUsuario'
          });

          if(json.decode(response.body)['row'].toString() != 'null'){
            reservas = List<Map<String, dynamic>>.from(json.decode(response.body)['row']);
          }

          if(!_personasInputTextController.toString().isEmpty){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder:(context)
                    {
                      return barra.BarraInferior();
                      //return listaT.ListarTours();
                    }
                )
            );
          }
          _alert('Reserva agregada',context);
        }
      }catch(_){
        _alert('Datos incorrectos',context);
      }
    }
  }

  bool _verifyData(fechaEntrada,fechaSalida,costoNeto,costoTotal,context){
    if(fechaEntrada == '' || fechaSalida == '' || costoNeto == '' || costoTotal == ''){
      _alert('Los campos no pueden estar vacios',context);
      return false;
    }else return true;
  }

  void _alert(message,context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(message, style: Theme.of(context).textTheme.headline6),
        actions: <Widget>[
          TextButton(
            child: const Text('Volver'),
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
        ],
      );
    });
  }

  List<DropdownMenuItem<String>> get PersondropdownItems{
    const List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("1"),  value: "1"),
      DropdownMenuItem(child: Text("2"),   value: "2"),
      DropdownMenuItem(child: Text("3"),   value: "3"),
      DropdownMenuItem(child: Text("4"),   value: "4"),
      DropdownMenuItem(child: Text("5"),   value: "5"),
      DropdownMenuItem(child: Text("6"),   value: "6"),
      DropdownMenuItem(child: Text("7"),   value: "7"),
      DropdownMenuItem(child: Text("8"),   value: "8"),
    ];
    return menuItems;
  }

  int activeIndex= 0;

  getReservas() async {
    var desc = barra.desc;
    var buscar = barra.buscar.text;

    //para telefono
    // var urlH = Uri.parse('http://10.0.2.2:4000/servicios/Hoteles');
    // var urlV = Uri.parse('http://10.0.2.2:4000/servicios/Viajes');
    // var urlR = Uri.parse('http://10.0.2.2:4000/servicios/Restaurantes');
    // var urlT = Uri.parse('http://10.0.2.2:4000/servicios/Tour');
    // var urlP = Uri.parse('http://10.0.2.2:4000/servicios/Paquetes');

    // para web
    var urlH = Uri.parse('http://localhost:4000/servicios/Hoteles');
    var urlV = Uri.parse('http://localhost:4000/servicios/Viajes');
    var urlR = Uri.parse('http://localhost:4000/servicios/Restaurantes');
    var urlT = Uri.parse('http://localhost:4000/servicios/Tour');
    var urlP = Uri.parse('http://localhost:4000/servicios/Paquetes');
    var urlRes = Uri.parse('http://localhost:4000/reservas/Listar');

    var responseH = await http.get(urlH);
    var responseV = await http.get(urlV);
    var responseR = await http.get(urlR);
    var responseT = await http.get(urlT);
    var responseP = await http.get(urlP);
    var responseRes = await http.get(urlRes);

    if(json.decode(responseH.body)['row'].toString() != 'null'){
      ServiciosH = List<Map<String, dynamic>>.from(json.decode(responseH.body)['row']);
    }
    if(json.decode(responseV.body)['row'].toString() != 'null'){
      ServiciosV = List<Map<String, dynamic>>.from(json.decode(responseV.body)['row']);
    }
    if(json.decode(responseR.body)['row'].toString() != 'null'){
      ServiciosR = List<Map<String, dynamic>>.from(json.decode(responseR.body)['row']);
    }
    if(json.decode(responseT.body)['row'].toString() != 'null'){
      ServiciosT = List<Map<String, dynamic>>.from(json.decode(responseT.body)['row']);
    }
    if(json.decode(responseP.body)['row'].toString() != 'null'){
      ServiciosP = List<Map<String, dynamic>>.from(json.decode(responseP.body)['row']);
    }
    if(json.decode(responseRes.body)['row'].toString() != 'null'){
      reservaciones = List<Map<String, dynamic>>.from(json.decode(responseRes.body)['row']);
    }

    if(desc == 0){
      ServiciosData2.addAll(ServiciosH);
      ServiciosData2.addAll(ServiciosV);
      ServiciosData2.addAll(ServiciosR);
      ServiciosData2.addAll(ServiciosT);
      ServiciosData2.addAll(ServiciosP);
      setState(() {
        _costoNetoInputTextController.text = "\$0.00";
        _costoTotalInputTextController.text = "\$0.00";
      });
    }
    if(desc == 1){
      setState(() {ServiciosData.addAll(ServiciosH);});
    }

    if(buscar != ""){
      for(int i = 0; i < ServiciosData2.length; i++){
        if(ServiciosData2[i]["Nombre"].toString().contains(buscar)){
          ServiciosData.add(ServiciosData2[i]);
        }
      }
      setState(() {
        ServiciosData;
      });
    }else{
      setState(() {
        ServiciosData.addAll(ServiciosData2);
      });
    }

  }

  @override
  void initState() {
    super.initState();
    getReservas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: Theme
              .of(context)
              .textTheme
              .bodyText1!
              .fontSize! * 4.5,
          width: 500,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: const Text(
            "",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            itemCount: ServiciosData == null ? 0 : ServiciosData.length,
            itemBuilder: (ctx, i) {
              return Container(
                margin: EdgeInsets.all(5),
                child: RaisedButton(
                  color: Colors.white,

                  onPressed: (){
                    if(ServiciosData[i]["idUsuario"] != null){
                      _idEmpresa = ServiciosData[i]["idUsuario"];
                      _onChangeReserva(i,_idEmpresa);
                    }
                    if(ServiciosData[i]["idUsuario"] != null) {
                      _idEmpresa = ServiciosData[i]["idUsuario"];
                      _onChangeReserva(i,_idEmpresa);
                    }
                    if(ServiciosData[i]["idUsuario"] != null) {
                      _idEmpresa = ServiciosData[i]["idUsuario"];
                      _onChangeReserva(i,_idEmpresa);
                    }
                    if(ServiciosData[i]["idUsuario"] != null) {
                      _idEmpresa = ServiciosData[i]["idUsuario"];
                      _onChangeReserva(i,_idEmpresa);
                    }
                    if(ServiciosData[i]["idUsuario"] != null) {
                      _idEmpresa = ServiciosData[i]["idUsuario"];
                      _onChangeReserva(i,_idEmpresa);
                    }
                  },
                  // child: Card(
                  child: Container(
                    height: 290,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                '${ServiciosData[i]["Imagen"].toString()}',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              '${ServiciosData[i]["Nombre"].toString()}',
                              style: const TextStyle(
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 5, top: 4),
                                    child: const Icon(
                                      Icons.star,
                                      color: Colors.red,
                                      size: 10,
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 5,
                                          bottom:5,
                                          top: 4),
                                      child: Text(
                                        "${ServiciosData[i]["Calificacion"].toString()}",
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      )
                                  ),
                                ]
                            ),
                            Row(
                              children:  [
                                Text(
                                  'Desde ${ServiciosData[i]["Costo"].toString()} MXM p/p',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 5,
              mainAxisExtent: 264,
            ),
          ),
        ),
      ],
    );
  }



  void _onChangeReserva(index,idUsuario) {
    var id=index;
    var calificacion = ServiciosData[index]["Calificacion"];
    // print(ServiciosData[index].toString());

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) {
                final CarouselController _controller = CarouselController();
                final List<String>  images = [
                  ServiciosData[index]["Imagen"].toString(),
                  ServiciosData[index]["Imagen"].toString(),
                  ServiciosData[index]["Imagen"].toString(),
                  ServiciosData[index]["Imagen"].toString(),
                  ServiciosData[index]["Imagen"].toString(),
                  ServiciosData[index]["Imagen"].toString(),
                  ServiciosData[index]["Imagen"].toString(),
                ];



                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Reservar', style: TextStyle(color: Colors.black),),
                    backgroundColor: Colors.white,
                    //centerTitle: true,
                    iconTheme: const IconThemeData(color: Colors.black),
                    leading: IconButton( //menu icon button at start left of appbar
                      onPressed: (){
                        _fechaEntradaInputTextController.text = "";
                        _fechaSalidaInputTextController.text = "";
                        _personasInputTextController.text = "";
                        _costoNetoInputTextController.text = "\$0.00";
                        _costoTotalInputTextController.text = "\$0.00";
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  body: Center(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 390,
                              viewportFraction: 1,
                              autoPlay: true,
                              onPageChanged: (index, reason) =>
                                  setState(()=> activeIndex = index),
                            ),
                            itemCount: images.length,
                            itemBuilder: (context, index, realindex) {
                              final image = images[index];
                              return buildImage(image, index);
                            },
                          ),

                          const SizedBox(height: 10,),

                          SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 16, right: 16),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              ServiciosData[index]["Nombre"],
                                              style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          Row(
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: const Icon(
                                                    Icons.star,
                                                    color: Colors.red,
                                                    size: 15,
                                                  ),
                                                ),
                                                Container(
                                                    margin: const EdgeInsets.only(
                                                        left: 5,
                                                        bottom: 5,
                                                        top: 2),
                                                    child: Text(
                                                      "$calificacion",
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    )
                                                ),
                                              ]
                                          ),

                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "https://th.bing.com/th/id/OIP.DqQp2MTPz9G8kcWeHoAj8gHaIv?pid=ImgDet&rs=1",
                                                      ),
                                                      alignment: Alignment.topRight,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ]
                                          ),

                                          Container(
                                            margin: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              "Costo: ${ServiciosData[index]["Costo"].toString()}",
                                              style: const TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            child: const Divider(
                                              color: Colors.black54,
                                              thickness: 1,
                                            ),
                                          ),

                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5,
                                                top: 5),
                                            child: const Text(
                                              "¿Qué harás?",
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            child: Text(
                                              ServiciosData[index]["Descripcion"].toString(),
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                width: 300,
                                                margin: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                                                child: RaisedButton(
                                                    color: Colors.red,
                                                    textColor: Colors.white,
                                                    child: const Text(
                                                      "Reservar",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    onPressed: () { _onPressReserva(id,idUsuario);}),
                                              ),
                                            ],
                                          ),
                                        ]
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                  ),
                );
              }
          )
      );
    });
  }

  void _onPressReserva(index,idUsuario) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
                title: const Text('Confirmar', style: TextStyle(color: Colors.black),),
                backgroundColor: Colors.white,
                //centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.black)
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(left:10, top: 30, bottom: 30),
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                            color: Colors.yellow,  //PARA PROBAR CONTAINER
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage("${ServiciosData[index]["Imagen"].toString()}"),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const[
                              BoxShadow(
                                //SOMBRA
                                color: Color(0xffA4A4A4),
                                offset: Offset(1.0, 5.0),
                                blurRadius: 3.0,
                              ),
                            ]
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left:16, top: 30, bottom: 30, right: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget> [
                                Container(
                                  child: Text(
                                    "${ServiciosData[index]["Nombre"].toString()}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${ServiciosData[index]["Descripcion"].toString()}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(
                    color: Colors.black38,
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left:10, right: 10, top: 20),
                    child: const Text(
                      "Tu viaje",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left:10, right: 10, top: 20),
                    child: Text(
                        "Folio: ${reservaciones.length+1}",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left:10, right: 10, top: 20),
                    child: const Text(
                      "Fechas",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(left:20 ,right: 20),
                          margin: const EdgeInsets.only(top:5 ,bottom: 15),
                          // height:150,
                          child:Center(
                              child:TextField(
                                controller: _fechaEntradaInputTextController, //editing controller of this TextField
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today), //icon of text field
                                    labelText: "Fecha de Entrada" //label text of field
                                ),
                                readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101)
                                  );

                                  if(pickedDate != null ){
                                    // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      _fechaEntradaInputTextController.text = formattedDate; //set output date to TextField value.
                                      calcularCosto(index);
                                    });
                                  }else{
                                    print("Date is not selected");
                                  }
                                },
                              )
                          )
                      ),
                    ],
                  ),

                  Column(
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(left:20 ,right: 20),
                          margin: const EdgeInsets.only(top:10),
                          // height:150,
                          child:Center(
                              child:TextField(
                                controller: _fechaSalidaInputTextController, //editing controller of this TextField
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today), //icon of text field
                                    labelText: "Fecha de Salida" //label text of field
                                ),
                                readOnly: true,  //set it true, so that user will not able to edit text
                                onTap: () async {
                                  calcularCosto(index);
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context, initialDate: DateTime.now(),
                                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101)
                                  );

                                  if(pickedDate != null ){
                                    // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement
                                    setState(() {
                                      _fechaSalidaInputTextController.text = formattedDate; //set output date to TextField value.
                                      calcularCosto(index);
                                    });
                                  }else{
                                    print("Date is not selected");
                                  }
                                },
                              )
                          )
                      ),
                    ],
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left:10, right: 10, top: 20),
                    child: const Text(
                      "Persona(s)",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: const EdgeInsets.only(left:12, right: 12, bottom: 15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(93, 93, 93, 0.1), borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _personasInputTextController,
                      decoration: const InputDecoration(
                        hintText: '...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const Divider(
                    color: Colors.black38,
                  ),

                  Container(
                    width: Theme.of(context).textTheme.bodyText1!.fontSize! * 24,
                    margin: const EdgeInsets.only(left:6, right: 6, top: 50, bottom: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        // side: BorderSide(color: Colors.red, width: 1),
                      ),
                      onPressed:(){
                        setState(() {
                          calcularCosto(index);
                        });
                      } ,

                      child: const Text(
                        'Calcular costo',
                        style: TextStyle(
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ),

                  const Divider(
                    color: Colors.black38,
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left:10, right: 10, top: 20),
                    child: const Text(
                      "Detalles de precio",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          width: 200,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                              "\$${ServiciosData[index]["Costo"].toString()}.00 MXN x Persona"
                          ),
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(top: 30),
                          child: TextField(
                            controller: _costoNetoInputTextController,
                            textAlign: TextAlign.right,
                            decoration: null,
                            readOnly: true,
                          ),
                        )
                      ],
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 200,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Comision por servicio",
                          textAlign: TextAlign.left,
                        ),
                      ),

                      Container(
                        width: 100,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "\$20.00",
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 200,
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                            "Impuestos"
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                            "\$10.00"
                        ),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 200,
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                            "Total"
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: _costoTotalInputTextController,
                          textAlign: TextAlign.right,
                          decoration: null,
                          readOnly: true,
                        ),
                      )
                    ],
                  ),


                  Container(
                    width: Theme.of(context).textTheme.bodyText1!.fontSize! * 24,
                    margin: const EdgeInsets.only(left:6, right: 6, top: 50, bottom: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        // side: BorderSide(color: Colors.red, width: 1),
                      ),
                      onPressed:(){_sendControllers (idUsuario);} ,

                      child: const Text(
                        'Confirmar Reserva',
                        style: TextStyle(
                          color: Colors.white,

                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void calcularCosto(index){
    //yyyy-mm-dd
    //0123456789

    if(!_fechaEntradaInputTextController.value.text.isEmpty &&
        !_fechaSalidaInputTextController.value.text.isEmpty){
      int mesInicio = int.parse(_fechaEntradaInputTextController.value.text.substring(5,7));
      int mesSalida = int.parse(_fechaSalidaInputTextController.value.text.substring(5,7));
      int diaInicio = int.parse(_fechaEntradaInputTextController.value.text.substring(8));
      int diaSalida = int.parse(_fechaSalidaInputTextController.value.text.substring(8));
      int personas = int.parse(_personasInputTextController.value.text);
      int costo = int.parse(ServiciosData[index]["Costo"].toString());
      print("personas = "+personas.toString());

      if(mesInicio == mesSalida){
        int diasTotales = diaSalida - diaInicio;
        int Neto = (personas * costo) *diasTotales;
        _costoNetoInputTextController.text = "\$"+(Neto.toString())+".00";
        _costoTotalInputTextController.text = "\$"+(Neto+30).toString()+".00";
      }else{
        int dias = 0;
        for(int i = 29; i < 32; i++){
          int yearInicio = int.parse(_fechaEntradaInputTextController.value.text.substring(0,4));
          int mes = DateTime(yearInicio, mesInicio, i).month;
          if(mes != mesInicio){
            dias = i;
            break;
          }
        }
        int diasTotales = (dias - diaInicio) + diaSalida;
        int Neto = (personas * costo) *diasTotales;
        _costoNetoInputTextController.text = "\$"+(Neto.toString())+".00";
        _costoTotalInputTextController.text = "\$"+(Neto+30).toString()+".00";
      }

    }

  }

  Widget buildImage(String image, int index) =>
      Container(
        color: Colors.grey,
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );
}
