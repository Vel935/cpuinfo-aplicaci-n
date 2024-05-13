import 'package:cpuinfo_application/main.dart';
import 'package:cpuinfo_application/models/user.dart';
import 'package:cpuinfo_application/pages/register/RegisterController.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  User user = User.empty();
  late RegisterController controller;

  @override
  Widget build(BuildContext context) {
    controller = RegisterController(key: _key, context: context);

    return Scaffold(
        appBar: MyAppBar(),
        // backgroundColor: const Color(0xFF35353),
        body: ListView(
          children: [formUserRegister(context)],
        ));
  }

  Form formUserRegister(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          children: [
            Positioned(
              top: 65,
              left: 27,
              child: _textRegister(),
            ),
            Positioned(top: 51, left: -5, child: _iconBack()),
            Container(
              width: double
                  .infinity, //ancho del contenedor, el double.infinity me centra los elementos
              margin: EdgeInsets.only(
                  top: 50), //me da una margen en la parte de arriba de 150 px
              child: SingleChildScrollView(
                //este es un widget que permite hacer scrooll en la pantalla, es decir pasar hacia abajo o hacia arriba un grupo de elemento en este caso los de la columna de abajo, es un widget necesario cuando se tienen muchos elementos en cascada o ves varios elementos desde un celular con una pantalla pequeña
                child: Column(
                  children: [
                    getLogo(), //funcion que me retorna el circulo donde va la imagen del usuario con una imagen predeterminada
                    SizedBox(
                      height: 20,
                    ), //esto hace un espacio entre la circulo y el text field de abajo
                    _textFieldEmail(), //esta funcion retorna un Campo de texto para ingresar el email
                    _textFieldPassword(), //esta funcion retorna un campo de texto para ingresar la contraseña
                    _buttonRegister(
                        context) //esta funcion retorna un boton que tiene un texto adentro que dice REGISTRASE
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _textRegister() {
    //funcion que retorna un texto que dice LOGIN
    return const Text(' REGISTRO',
        style: TextStyle(
            //text tiene una propiedad llamada style, que permite modificar los estilos del texto
            color: Colors.white, //esto cambia el color del texto
            fontWeight: FontWeight
                .bold, //esto le da cambia la fuente al texto, en este caso usamos bold y le ponemos negrita al texto
            fontSize: 20, //esto cambia el tamaño de la fuente
            fontFamily:
                'NimbusSans' //esto cambia la fuente de la letra, usando las letras que tenemos en assets y llamando a la familia que especificamos en el archivo pubspec.yaml
            ));
  }

  Widget _buttonRegister(BuildContext context) {
    //funcion que me genera el boton Ingresar
    return Container(
      width: double.infinity, //ancho del boton
      margin: EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20), //margen horizontal y vertical del boton
      child: ElevatedButton(
          onPressed: () {
            controller.signup(user.mail, user.password);
            controller.createUser({
              'mail': user.mail,
              'password': user.password,
            }).then((id) {
              print(id);
            }).catchError((e) {
              print(e);
            });
          },
          child: Text('REGISTRARSE'),
          style: ElevatedButton.styleFrom(
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

  Widget _textFieldEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
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

  Widget _textFieldPassword() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Contraseña',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.lock),
            ),
            onChanged: (value) => user.password = value,
            validator:
                controller.validPasswordField, // Aquí se asigna el validador
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Confirmar contraseña',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              prefixIcon: Icon(Icons.lock_outline),
            ),
            onChanged: (value) => value,
            validator: (value) => controller.validConfirmPasswordField(
                value: value,
                password: user.password), // Aquí se asigna el validador
          ),
        ],
      ),
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

  Widget _iconBack() {
    return IconButton(
        //esta es una propiedad(creo) que recibe un evento onPressed y un icono, esta propiedad permite hacer botones con forma de iconos
        onPressed:
            () {}, //cuando presiones el boton se retroce a la pagina anterior en este caso el login
        icon: const Icon(Icons.arrow_back_ios,
            color: Colors
                .white) //la propiedad icon recibe el icono que en este caso es una flecha (Icons.arrow_back_ios), y opcionalmente el color de este, en este caso es blanco
        );
  }
}
