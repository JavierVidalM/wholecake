import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login_main.dart';
<<<<<<< Updated upstream
import 'package:wholecake/views/home/home_page.dart';
=======
>>>>>>> Stashed changes

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});
  @override
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbde0fe),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 64.0),
                height: 125.0,
                width: 312.0,
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/logo_SW.png'),
              ),
              SizedBox(height: 48.0),
              Container(
                margin: EdgeInsets.only(top: 45),
                width: 333,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ingrese su correo electrónico',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3681AB), width: 4),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 333,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Ingrese su contraseña',
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3681AB), width: 4),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                width: 333,
                child: TextButton(
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Color(0xFF3681AB)),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: 333,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                        disabledColor: Colors.white,
                      ),
                      child: Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        checkColor: Colors.white,
                        activeColor: Color(0xFF3681AB),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                      child: Text(
                        'Recuérdame',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 293,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFB5D7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text('Iniciar sesión'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
<<<<<<< Updated upstream
=======
              SizedBox(height: 16.0),
>>>>>>> Stashed changes
              Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 293,
                  height: 60,
                  child: TextButton(
                    onPressed: () {
<<<<<<< Updated upstream
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginMain()));
                    },
                    child: const Text(
                      "Regresar",
=======
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginMain()));
                    },
                    child: const Text(
                      'Regresar',
>>>>>>> Stashed changes
                      style: TextStyle(color: Color(0xFF3681AB), fontSize: 18),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
