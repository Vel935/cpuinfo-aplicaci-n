import 'package:cpuinfo_application/pages/registerPage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double
          .infinity, //le damos un ancho al contenedor, este ancho tiempo un ancho de toda la pantalla, como no sabemos los pixeles exactos que tiene usamos el double.infinity
      child: Stack(
        children: [
          Positioned(
            top: 60,
            left: 25,
            child: textLogin(),
          ),
          SingleChildScrollView(
            child: Column(
              //ocupamos la columna para poner elementos uno debajo del otro
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //aqui adentro de children pondremos todo el contenido de la columna
                //_imageBanner(), //llamamos al metodo que nos muestra la imagen que aparece en la pantalla
                Container(
                  child: getLogo(),
                ),
                textFieldEmail(), //metodo que genera un espacio para ingresar informacion (TextField), en este caso el correo
                textFieldPassword(), //metodo que genera un campo de texto para ingresar la contraseña
                buttonLogin(), //Metodo que genera un boton para enviar los datos, en este caso se llama ingresar
                textDontHaveAccount() //metodo que genera dos textos en una fila "no tienes cuenta" y "registrate"
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget textLogin() {
    //funcion que retorna un texto que dice LOGIN
    return Text('LOGIN',
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
    //funcion que me genera un TextFiled para ingresar el Email
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 50, vertical: 5), //margen horizontal del TextFile
      decoration: BoxDecoration(
          //el container tiene una propiedad decartion
          // color: MyColors.primaryOpacityColor, //este es el color de fondo del recuadro del textfield
          borderRadius: BorderRadius.circular(
              30) //este es el borde del text field, en este caso estamos redondenado el recuadro
          ),
      child: TextField(
        keyboardType: TextInputType
            .emailAddress, //esto genera un arroba en el teclado cuando vaya a escribir algo sobre este textField
        decoration: InputDecoration(
            hintText: 'Correo electronico',
            border: InputBorder
                .none, //esto elimina el borde que hay en la parte inferior del reacuadro del textfield
            contentPadding: EdgeInsets.all(
                15), //este es el margen que hay entre el reacuadro del textfield y el texto de adentro, en este caso hay un margen en todas las direcciones de 15 px
            prefixIcon: Icon(
              Icons
                  .email, //el  decoration  del child de textfield tiene esta propiedad que permite poner iconos en este caso usamos un icono de email y este se pone de forma predeterminada antes del texto "correo electronico"
              //para mas iconos buscar en google  icons material e ingresar a la pagina "Material Icons (Google) - Google Fonts"
              // color: MyColors.primaryColor //esto me cambia el color del icono, de forma predeterminada es gris
            ),
            hintStyle: TextStyle(
                //esta propiedad sirve para modificar los estilos del hintext que vendria siendo el texto
                // color: MyColors.primaryColorDark
                )),
      ),
    );
  }

  Widget textFieldPassword() {
    //funcion que me genera un TextField para ingresar la contraseña
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 50, vertical: 5), //margen horizontal del TextFile
      decoration: BoxDecoration(
          //el container tiene una propiedad decartion
          // color: MyColors.primaryOpacityColor, //este es el color de fondo del recuadro del textfield
          borderRadius: BorderRadius.circular(
              30) //este es el borde del text field, en este caso estamos redondenado el recuadro
          ),
      child: TextField(
        // controller: _con.passwordController,
        obscureText:
            true, //esto sirve para que el texto del textfield se oculte cuando escribamos en el, en vez de ir mostrandonos letras se nos muestra circulitos
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder
                .none, //esto elimina el borde que hay en la parte inferior del reacuadro del textfield
            contentPadding: EdgeInsets.all(
                15), //este es el margen que hay entre el reacuadro del textfield y el texto de adentro, en este caso hay un margen en todas las direcciones de 15 px
            prefixIcon: Icon(
              Icons
                  .lock, //el  decoration  del child de textfield tiene esta propiedad que permite poner iconos en este caso usamos un icono de un candado y este se pone de forma predeterminada antes del texto "contraseña"
              //para mas iconos buscar en google  icons material e ingresar a la pagina "Material Icons (Google) - Google Fonts"
              // color: MyColors.primaryColor //esto me cambia el color del icono, de forma predeterminada es gris
            ),
            hintStyle: TextStyle(
                //esta propiedad sirve para modificar los estilos del hintext que vendria siendo el texto
                // color: MyColors.primaryColorDark
                )),
      ),
    );
  }

  Widget buttonLogin() {
    //funcion que me genera el boton Ingresar
    return Container(
      width: double.infinity, //ancho del boton
      margin: EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20), //margen horizontal y vertical del boton
      child: ElevatedButton(
          onPressed:
              () {}, // onPressed: _con.login, //esto es para que cuando se presione el boton INGRESAR se llame a la funcion "login" del controlador
          child: Text('INGRESAR'),
          style: ElevatedButton.styleFrom(
              //elevated buttom tiene una propiedad llamada style
              // primary: MyColors.primaryColor, //esto cambia el color del boton llamando a la clase que creamos con anterioridad
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30) //con esto redondeamos la forma del boton
                  ),
              padding: EdgeInsets.symmetric(
                  vertical:
                      15) //margen interior para el boton, esto puede modificar la forma del boton
              )),
    );
  }

  Widget textDontHaveAccount() {
    //metodo que genera dos textos en una fila
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿No tienes cuenta?',
            style: TextStyle(
                // color: MyColors.primaryColor
                )),
        SizedBox(width: 7),
        GestureDetector(
          //este es un widget que envuelve a el texto 'Registrate' para lograr que sea un texto cliqueable
          // onTap: _con.goToRegisterPage, //aqui usamos el objeto _con, que es una instancia del controlador login_controller, para usar un metodo que abre la ruta de la pagina de registro, para mas informacion leer abajito

          onTap: () {
            //onTap es un evento donde se puede definir que codigo se va a ejecutar  si se cliquea el texto
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RegisterPage())); //esto sirve para navegar a otra pantalla, el metodo pide un contexto y una ruta, el contexto (vive de manera global en nuestra clase) lo dejamos igual y en la ruta ponemos a que pagina se va a dirijir al hacer click dependiendo de las rutas definidas en el main
            //el codigo  de aqui arriba ha sido movido a un metodo del archivo login_controller
          },
          child: Text(
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
      'assets/img/logo.png', // Ruta de la imagen dentro de la carpeta assets
      width: 200, // Ancho deseado de la imagen
      height: 200, // Alto deseado de la imagen
      fit: BoxFit.contain, // Ajuste de la imagen dentro del contenedor
    );
  }
}
