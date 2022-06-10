import 'package:flutter/material.dart';
import 'package:proyectotmp/src/descubrir.dart';
import '../barra_inferior/barrainf.dart' as barra;

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _Home();
  }
}

class _Home extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children:<Widget>[


    Container(
    margin:  const EdgeInsets.only(left: 5, top: 5),
    width: 60,
    height: 250,
    decoration: BoxDecoration(
    color: Colors.black87,
    image: const DecorationImage(
    image: AssetImage ('assets/MORELIATURISMO.png'),
    fit: BoxFit.fill,
    ),
    ),
    ),

          Container(

            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left:16, right: 10, top: 30),
            child: Text(
                "¡Bienvenido!",
                textAlign: TextAlign.left,
                style: TextStyle(
                   fontSize: 28,
                   fontWeight: FontWeight.w500,
                   color: Colors.black87,
                ),
            ),
          ),



        Container(
          height: 400,
          width: Theme.of(context).textTheme.bodyText1!.fontSize! * 30,
          margin:  const EdgeInsets.only(left: 16, right:16, top: 25, bottom: 25),
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage ('assets/janitzio.jpg'),
                fit: BoxFit.fill,
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
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, right:16, top: 25, bottom: 4),
                child: const Text(
                  "PATZCUARO \n Conoce este pueblo mágico y\n descubre lo que puede ofrecer",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, right:16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 30, right:30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: Colors.red,
                    onPrimary: Colors.black12,
                    // side: BorderSide(color: Colors.red, width: 1),
                  ),
                  onPressed: (){},
                  child: const Text(
                    'Mas informacion',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

          Container(
            height: 400,
            width: Theme.of(context).textTheme.bodyText1!.fontSize! * 30,
            margin:  const EdgeInsets.only(left: 16, right:16, top: 25, bottom: 25),
            decoration: BoxDecoration(
                color: Colors.black87,  //PARA PROBAR CONTAINER
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                  image: AssetImage ('assets/img.jpg'),
                  fit: BoxFit.fill,
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
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right:16, top: 25, bottom: 4),
                  child: const Text(
                    "CONOCE MICHOACAN",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, right:16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left: 30, right:30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: Colors.red,
                      onPrimary: Colors.black12,
                      // side: BorderSide(color: Colors.red, width: 1),
                    ),
                    onPressed: (){},
                    child: const Text(
                      'Mas informacion',
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        Container(
          height: 400,
          width: Theme.of(context).textTheme.bodyText1!.fontSize! * 30,
          margin:  const EdgeInsets.only(left: 16, right:16, top: 18, bottom: 25),
          decoration: BoxDecoration(
              color: Colors.black,  //PARA PROBAR CONTAINER
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage ('assets/Cocas.png'),
                // NetworkImage("https://cdn2.cocinadelirante.com/sites/default/files/styles/gallerie/public/images/2020/09/como-se-hacen-las-carnitas-facil.jpg"),
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
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, right:16, top: 25, bottom: 4),
                child: const Text(
                  "Disfruta de\nnuestra gastronomía",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 16, right:16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(left: 30, right:30),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    primary: Colors.red,
                    onPrimary: Colors.black12,
                    // side: BorderSide(color: Colors.red, width: 1),
                  ),
                  onPressed: (){},
                  child: const Text(
                    '¡Quiero probarlas!',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}