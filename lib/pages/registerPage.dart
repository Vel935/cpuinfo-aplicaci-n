import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 65,
                  left: 27,
                  child: _textRegister(),
                ),
                Positioned(top: 51, left: -5, child: _iconBack()),

                //HASTA ACA ES LA FORMA ROJA DE LA PARTE SUPERIOR DE LA PANTALLA QUE DICE REGISTRO DE AQUI EN ADELANTE
                //ES EL FORMULARIO

                Container(
                  width: double
                      .infinity, //ancho del contenedor, el double.infinity me centra los elementos
                  margin: EdgeInsets.only(
                      top:
                          150), //me da una margen en la parte de arriba de 150 px
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
                        _buttonRegister() //esta funcion retorna un boton que tiene un texto adentro que dice REGISTRASE
                      ],
                    ),
                  ),
                )
              ],
            )));
    ;
  }

  Widget _textRegister() {
    //funcion que retorna un texto que dice LOGIN
    return Text(' REGISTRO',
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

  Widget _buttonRegister() {
    //funcion que me genera el boton Ingresar
    return Container(
      width: double.infinity, //ancho del boton
      margin: EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20), //margen horizontal y vertical del boton
      child: ElevatedButton(
          onPressed: () {},
          // onPressed: _con
          //     .register, //cuando se presione el boton REGISTRARSE se ejecuta la funcion register del controlador
          child: Text('REGISTRARSE'),
          style: ElevatedButton.styleFrom(
              //elevated buttom tiene una propiedad llamada style
              // primary: MyColors
              //     .primaryColor, //esto cambia el color del boton llamando a la clase que creamos con anterioridad
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

  Widget _textFieldEmail() {
    //funcion que me genera un TextFiled para ingresar el Email
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      //margen horizontal del TextFile
      decoration: BoxDecoration(
          //el container tiene una propiedad decoration
          // color: MyColors.primaryOpacityColor,
          //este es el color de fondo del recuadro del textfield
          borderRadius: BorderRadius.circular(
              30) //este es el borde del text field, en este caso estamos redondenado el recuadro
          ),
      child: TextField(
        // controller: _con
        //     .emailController, //para mas info ir a login_page en la funcion paralela a esta en ese archivo
        keyboardType: TextInputType
            .emailAddress, //para mas info ir a login_page en la funcion paralela a esta en ese archivo
        decoration: InputDecoration(
          hintText: 'Correo electronico',
          border: InputBorder.none,
          //esto elimina el borde que hay en la parte inferior del reacuadro del textfield
          contentPadding: EdgeInsets.all(15),
          //este es el margen que hay entre el reacuadro del textfield y el texto de adentro, en este caso hay un margen en todas las direcciones de 15 px
          prefixIcon: Icon(
            Icons.email,
            //el  decoration  del child de textfield tiene esta propiedad que permite poner iconos en este caso usamos un icono de email y este se pone de forma predeterminada antes del texto "correo electronico"
            //para mas iconos buscar en google  icons material e ingresar a la pagina "Material Icons (Google) - Google Fonts"
            // color: MyColors
            //     .primaryColor //esto me cambia el color del icono, de forma predeterminada es gris
          ),
          // hintStyle: TextStyle(
          //     //esta propiedad sirve para modificar los estilos del hintext que vendria siendo el texto
          //     color: MyColors.primaryColorDark)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    //funcion que me genera un TextFiled para ingresar el Email
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        //margen horizontal del TextFile
        decoration: BoxDecoration(
            //el container tiene una propiedad decoration
            // color: MyColors.primaryOpacityColor,
            //este es el color de fondo del recuadro del textfield
            borderRadius: BorderRadius.circular(
                30) //este es el borde del text field, en este caso estamos redondenado el recuadro
            ),
        child: TextField(
          // controller: _con.passwordController, //controlador de este TextField
          obscureText:
              true, //para ocultar lo que se escriba en este campo de texto, al escribir en ves de letras se muestran puntos
          decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            //esto elimina el borde que hay en la parte inferior del reacuadro del textfield
            contentPadding: EdgeInsets.all(15),
            //este es el margen que hay entre el reacuadro del textfield y el texto de adentro, en este caso hay un margen en todas las direcciones de 15 px
            prefixIcon: Icon(
              Icons.lock,
              //el  decoration  del child de textfield tiene esta propiedad que permite poner iconos en este caso usamos un icono de email y este se pone de forma predeterminada antes del texto "correo electronico"
              //para mas iconos buscar en google  icons material e ingresar a la pagina "Material Icons (Google) - Google Fonts"
              // color: MyColors
              //     .primaryColor //esto me cambia el color del icono, de forma predeterminada es gris
            ),
            // hintStyle: TextStyle(
            //     //esta propiedad sirve para modificar los estilos del hintext que vendria siendo el texto
            //     color: MyColors.primaryColorDark)),
          ),
        ));
  }

  Widget getLogo() {
    return Image.asset(
      'assets/img/logo.png', // Ruta de la imagen dentro de la carpeta assets
      width: 200, // Ancho deseado de la imagen
      height: 200, // Alto deseado de la imagen
      fit: BoxFit.contain, // Ajuste de la imagen dentro del contenedor
    );
  }

  Widget _iconBack() {
    return IconButton(
        //esta es una propiedad(creo) que recibe un evento onPressed y un icono, esta propiedad permite hacer botones con forma de iconos
        onPressed:
            () {}, // onPressed: _con.back, //cuando presiones el boton se retroce a la pagina anterior en este caso el login
        icon: Icon(Icons.arrow_back_ios,
            color: Colors
                .white) //la propiedad icon recibe el icono que en este caso es una flecha (Icons.arrow_back_ios), y opcionalmente el color de este, en este caso es blanco
        );
  }
}
