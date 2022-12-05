import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

// una interfaz muy sencilla en la que podemos crear los tres usuarios (signup)
// y después logearse (login) con cualquiera de las tres

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({Key? key}) : super(key: key);
  final AuthenticationController authenticationController = Get.find();

  void signIn() async {
    // aquí creamos los tres usuarios
    await authenticationController.signup('edwin@gmail.com', '123456');
    await authenticationController.signup('nelly@gmail.com', '123456');
    await authenticationController.signup('stiven@gmail.com', '123456');
  }

  void login(String user) {
    // método usado para login
    authenticationController.login(user, '123456');
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 4, 144, 102),
          contentTextStyle: const TextStyle(color: Colors.white),
          title: const Text(
            ' ¡¡¡ Importante !!!',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(children: const [
              Text(
                  'Antes de crear los usuarios, borrar todos los usuarios del sistema de autenticación y la base de datos de tiempo real de firebase')
            ]),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  signIn();
                  Navigator.pop(context);
                },
                child: const Text('Continuar')),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.white60),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 82, 125, 13),
      body: SingleChildScrollView(
        child: Form(
          child: Column(children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 0.0),
              child: Text(
                'CHAT DE LA UNIVESIDAD',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 50.0, left: 25),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.network(
                        'https://raw.githubusercontent.com/luisserranopro/curso-flutter/master/19firebaseapp/assets/auth.png')),
              ),
            ),

// ************************* container 1 *********** *********************************************************************************************

            Container(
              height: 60,
              width: 350,
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  _mostrarAlerta(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: <Widget>[
                      Image.network('https://i.imgur.com/QTINPQt.png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, right: 55),
                        child: Text(
                          'Crear tres usuarios',
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 26, 223, 36),
                            fontWeight: FontWeight.w500,
                            backgroundColor: Color.fromARGB(0, 85, 68, 68),
                            letterSpacing: 0.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  shadowColor: Colors.black45,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.white70,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

// **********************************   container 2       *******************************************************************************
            Container(
              height: 60,
              width: 350,
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () => login('edwin@gmail.com'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: <Widget>[
                      Image.network('https://i.imgur.com/3aJi0Sv.png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, right: 55),
                        child: Text(
                          'Ingresar con Edwin',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.transparent,
                            letterSpacing: 0.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  shadowColor: Colors.black45,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.white70,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
// *****************************   container 3          ************************************************************************************
            Container(
              height: 60,
              width: 350,
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () => login('nelly@gmail.com'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: <Widget>[
                      Image.network('https://i.imgur.com/3aJi0Sv.png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, right: 55),
                        child: Text(
                          'Ingresar con Nelly',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.transparent,
                            letterSpacing: 0.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  shadowColor: Colors.black45,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.white70,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
// *****************   container 4    ************************************************************************************************
            Container(
              height: 60,
              width: 350,
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () => login('stiven@gmail.com'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    children: <Widget>[
                      Image.network('https://i.imgur.com/3aJi0Sv.png'),
                      const Padding(
                        padding: EdgeInsets.only(left: 40, right: 55),
                        child: Text(
                          'Ingresar con Stiven',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.transparent,
                            letterSpacing: 0.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onPrimary: Colors.white,
                  shadowColor: Colors.black45,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(
                      color: Colors.white70,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
