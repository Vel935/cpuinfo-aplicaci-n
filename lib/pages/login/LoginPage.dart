import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/models/user.dart';
import 'package:cpuinfo_application/pages/login/LoginController.dart';
import 'package:cpuinfo_application/pages/register/RegisterPage.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey();

  User user = User.empty();

  late LoginController controller;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller = LoginController(key: _key, context: context);

    return Scaffold(
        // backgroundColor: Colors.red,
        appBar: MyAppBar(),
        // backgroundColor: const Color(0xFF35353),
        body: Container(child: formLogin(context)));
  }

  Form formLogin(BuildContext context) {
    return Form(
        key: _key,
        child: Container(
          width: double
              .infinity, //le damos un ancho al contenedor, este ancho tiempo un ancho de toda la pantalla, como no sabemos los pixeles exactos que tiene usamos el double.infinity
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  //ocupamos la columna para poner elementos uno debajo del otro
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    //aqui adentro de children pondremos todo el contenido de la columna
                    //_imageBanner(), //llamamos al metodo que nos muestra la imagen que aparece en la pantalla
                    Container(
                      child: getLogo(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textFieldEmail(), //metodo que genera un espacio para ingresar informacion (TextField), en este caso el correo
                    textFieldPassword(), //metodo que genera un campo de texto para ingresar la contraseña
                    buttonLogin(), //Metodo que genera un boton para enviar los datos, en este caso se llama ingresar
                    getGoogleButton(),
                    SizedBox(
                      height: 20,
                    ),
                    textDontHaveAccount(
                        context) //metodo que genera dos textos en una fila "no tienes cuenta" y "registrate"
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget textLogin() {
    //funcion que retorna un texto que dice LOGIN
    return const Text('Iniciar Sesión',
        style: TextStyle(
            //text tiene una propiedad llamada style, que permite modificar los estilos del texto
            color: Colors.white, //esto cambia el color del texto
            fontWeight: FontWeight
                .bold, //esto le da cambia la fuente al texto, en este caso usamos bold y le ponemos negrita al texto
            fontSize: 22, //esto cambia el tamaño de la fuente
            fontFamily:
                'NimbusSans' //esto cambia la fuente de la letra, usando las letras que tenemos en assets y llamando a la familia que especificamos en el archivo pubspec.yaml
            ));
  }

  Widget textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Correo electrónico',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.email),
        ),
        onChanged: (value) => user.mail = value,
        validator: controller.validEmailField, // Aquí se asigna el validador
      ),
    );
  }

  Widget textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(Icons.lock),
        ),
        onChanged: (value) => user.password = value,
        validator: controller.validField, // Aquí se asigna el validador
      ),
    );
  }

  Widget buttonLogin() {
    //funcion que me genera el boton Ingresar
    return Container(
      width: double.infinity, //ancho del boton
      margin: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20), //margen horizontal y vertical del boton
      child: ElevatedButton(
          onPressed: () {
            //si cuando se llama la funcion de login retorna true, entonces se navega a la pagina de home
            userValidation();
          }, // onPressed: _con.login, //esto es para que cuando se presione el boton INGRESAR se llame a la funcion "login" del controlador
          child: Text(
            'INGRESAR',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF353535),
              //elevated buttom tiene una propiedad llamada style
              // primary: MyColors.primaryColor, //esto cambia el color del boton llamando a la clase que creamos con anterioridad
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30) //con esto redondeamos la forma del boton
                  ),
              padding: const EdgeInsets.symmetric(
                  vertical:
                      15) //margen interior para el boton, esto puede modificar la forma del boton
              )),
    );
  }

  Widget getGoogleButton() {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        userValidationWithGoogle(context);
      },
      child: Container(
        width: 300, // Ancho del contenedor
        padding: EdgeInsets.all(20), // Relleno dentro del contenedor
        decoration: BoxDecoration(
          color: isDarkMode
              ? Colors.grey[850]
              : Color.fromARGB(
                  255, 232, 232, 232), // Color de fondo del contenedor
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/google.png',
                width: 25, height: 25), // Imagen
            SizedBox(width: 10), // Espacio entre la imagen y el texto
            Text(
              "Inicia Sesión con Google",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ), // Texto debajo de la imagen
          ],
        ),
      ),
    );
  }

  // Widget buttonLoginWithGoogle() {
  //   //funcion que me genera el boton Ingresar
  //   return Container(
  //     width: double.infinity, //ancho del boton
  //     margin: const EdgeInsets.symmetric(
  //         horizontal: 50,
  //         vertical: 20), //margen horizontal y vertical del boton
  //     child: ElevatedButton(
  //         onPressed: () {
  //           //si cuando se llama la funcion de login retorna true, entonces se navega a la pagina de home
  //           userValidationWithGoogle(context);
  //         }, // onPressed: _con.login, //esto es para que cuando se presione el boton INGRESAR se llame a la funcion "login" del controlador
  //         child: Text('INGRESAR CON GOOGLE'),
  //         style: ElevatedButton.styleFrom(
  //             //elevated buttom tiene una propiedad llamada style
  //             // primary: MyColors.primaryColor, //esto cambia el color del boton llamando a la clase que creamos con anterioridad
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(
  //                     30) //con esto redondeamos la forma del boton
  //                 ),
  //             padding: const EdgeInsets.symmetric(
  //                 vertical:
  //                     15) //margen interior para el boton, esto puede modificar la forma del boton
  //             )),
  //   );
  // }

//____________________________
  Future<void> userValidation() async {
    print(controller.login(user.mail, user.password));
    if (await controller.signIn(user.mail, user.password)) {
      Navigator.pushNamedAndRemoveUntil(context, "firstPage", (route) => false);
      //Navigator.popAndPushNamed(context, 'firstPage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario no existe'),
          duration: Duration(seconds: 5),
        ),
      );
      print('Usuario no encontrado');
    }
  }

  // Future<void> userValidationWithGoogle() async {
  //   if (await controller.signInWithGoogle()) {
  //     Navigator.pushNamed(context, "firstPage");
  //     //Navigator.popAndPushNamed(context, 'firstPage');
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Fallo al iniciar sesión'),
  //         duration: Duration(seconds: 5),
  //       ),
  //     );
  //     print('Usuario no encontrado');
  //   }
  // }

  userValidationWithGoogle(BuildContext context) async {
    await controller.signInWithGoogle();

    Navigator.pushNamedAndRemoveUntil(context, "firstPage", (route) => false);
  }

//_____________________________________

  Widget textDontHaveAccount(BuildContext context) {
    //metodo que genera dos textos en una fila
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('¿No tienes cuenta?',
            style: TextStyle(
                // color: MyColors.primaryColor
                )),
        const SizedBox(width: 7),
        GestureDetector(
          //este es un widget que envuelve a el texto 'Registrate' para lograr que sea un texto cliqueable
          // onTap: _con.goToRegisterPage, //aqui usamos el objeto _con, que es una instancia del controlador login_controller, para usar un metodo que abre la ruta de la pagina de registro, para mas informacion leer abajito

          onTap: () {
            //onTap es un evento donde se puede definir que codigo se va a ejecutar  si se cliquea el texto
            Navigator.pushNamed(context,
                "register"); //esto sirve para navegar a otra pantalla, el metodo pide un contexto y una ruta, el contexto (vive de manera global en nuestra clase) lo dejamos igual y en la ruta ponemos a que pagina se va a dirijir al hacer click dependiendo de las rutas definidas en el main
            //el codigo  de aqui arriba ha sido movido a un metodo del archivo login_controller
          },
          child: const Text(
            'Registrate',
            style: TextStyle(
              //accedemos a la propiedad style de Text
              fontWeight: FontWeight
                  .bold, //por medio de esta propiedad ponemos al texto en negrita
              // color: MyColors.primaryColor //le damos un color bacano al texto usando la clase que creamos "MyColors"
            ),
          ),
        ),
      ],
    );
  }

  Widget getLogo() {
    return Image.asset(
      'assets/img/logo2.png', // Ruta de la imagen dentro de la carpeta assets
      width: 200, // Ancho deseado de la imagen
      height: 200, // Alto deseado de la imagen
      fit: BoxFit.contain, // Ajuste de la imagen dentro del contenedor
    );
  }
}
