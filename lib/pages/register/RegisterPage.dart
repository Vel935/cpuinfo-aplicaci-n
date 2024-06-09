import 'package:cpuinfo_application/models/user.dart';
import 'package:cpuinfo_application/pages/register/RegisterController.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  User user = User.empty();
  late RegisterController controller;
  String _selectedRole = 'Usuario';

  @override
  Widget build(BuildContext context) {
    controller = RegisterController(key: _key, context: context);

    return Scaffold(
      appBar: MyAppBar(),
      body: ListView(
        children: [formUserRegister(context)],
      ),
    );
  }

  Form formUserRegister(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  getLogo(),
                  SizedBox(height: 20),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _roleDropdown(),
                  _buttonRegister(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _roleDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: DropdownButtonFormField<String>(
        value: _selectedRole,
        items: <String>['Usuario', 'Administrador']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedRole = newValue!;
          });
        },
        decoration: InputDecoration(
          hintText: 'Selecciona el rol',
          contentPadding: EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
        ),
      ),
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
        validator: controller.validEmailField,
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
            validator: controller.validPasswordField,
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
                value: value, password: user.password),
          ),
        ],
      ),
    );
  }

  Widget _buttonRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          controller.signup(user.mail, user.password, _selectedRole);
          controller.createUser({
            'mail': user.mail,
            'password': user.password,
            'role': _selectedRole,
          }).then((id) {
            print(id);
          }).catchError((e) {
            print(e);
          });
        },
        child: Text('REGISTRARSE'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget getLogo() {
    return Image.asset(
      'assets/img/logo2.png',
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }
}
