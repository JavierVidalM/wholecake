// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:wholecake/services/users_services.dart';
// import 'package:wholecake/theme/theme.dart';
// import 'package:wholecake/views/login/login.dart';
// import 'package:wholecake/views/home/home_page.dart';
// import 'package:file_picker/file_picker.dart';

// class SigninUser extends StatefulWidget {
//   const SigninUser({Key? key}) : super(key: key);
//   @override
//   State<SigninUser> createState() => _SigninUserState();
// }

// class _SigninUserState extends State<SigninUser> {
//   TextEditingController nombreController = TextEditingController();
//   TextEditingController apellidoController = TextEditingController();
//   TextEditingController correoController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController password2Controller = TextEditingController();
//   TextEditingController admincodeController = TextEditingController();
//   File? imagen;

//   @override
//   void dispose() {
//     nombreController.dispose();
//     apellidoController.dispose();
//     correoController.dispose();
//     passwordController.dispose();
//     password2Controller.dispose();
//     admincodeController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveData() async {
//     final msg = jsonEncode({
//       'nombre': nombreController.text,
//       'apellido': apellidoController.text,
//       'correo': correoController.text,
//       'password': passwordController.text,
//       'password2': password2Controller.text,
//       'admincode': admincodeController.text,
//       'imagen': base64
//     });
//     await UserService().UsersAdd(msg);
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => LoginUser()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: SweetCakeTheme.loginTheme,
//       child: Scaffold(
//           body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Padding(
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.05),
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         'assets/images/logo_SW.png',
//                         height: MediaQuery.of(context).size.height * 0.15,
//                         // width: 150, // ajusta el ancho a tu preferencia
//                       ),
//                     ],
//                   )),
//               Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.03,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       left: MediaQuery.of(context).size.width * 0.08,
//                     ),
//                     child: InkWell(
//                       onTap: () async {
//                         final result = await FilePicker.platform.pickFiles(
//                           type: FileType.image,
//                         );
//                         if (result != null) {
//                           setState(() {
//                             imagen = File(result.files.single.path!);
//                           });
//                         }
//                       },
//                       child: Container(
//                         width: 80.0,
//                         height: 80.0,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color(0xFF909090),
//                         ),
//                         child: ClipOval(
//                           child: imagen != null
//                               ? Image.file(
//                                   imagen!,
//                                   width: 80.0,
//                                   height: 80.0,
//                                   fit: BoxFit.cover,
//                                 )
//                               : const Icon(
//                                   Icons.add,
//                                   size: 40.0,
//                                   color: Color(0xFFC0C0C0),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.01,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       left: MediaQuery.of(context).size.width * 0.08,
//                     ),
//                     child: TextField(
//                       controller: nombreController,
//                       decoration: const InputDecoration(
//                         hintText: "Nombre",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.04,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       left: MediaQuery.of(context).size.width * 0.08,
//                     ),
//                     child: TextField(
//                       controller: apellidoController,
//                       decoration: const InputDecoration(hintText: "Apellido"),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.04,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       left: MediaQuery.of(context).size.width * 0.08,
//                     ),
//                     child: TextField(
//                       keyboardType: TextInputType.emailAddress,
//                       controller: correoController,
//                       decoration: const InputDecoration(
//                         hintText: "Correo electrónico",
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.04,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       left: MediaQuery.of(context).size.width * 0.08,
//                     ),
//                     child: TextFormField(
//                       controller: passwordController,
//                       autocorrect: false,
//                       obscureText: true,
//                       decoration: const InputDecoration(hintText: "Contraseña"),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).size.height * 0.04,
//                       right: MediaQuery.of(context).size.width * 0.08,
//                       left: MediaQuery.of(context).size.width * 0.08,
//                     ),
//                     child: TextFormField(
//                       controller: password2Controller,
//                       autocorrect: false,
//                       obscureText: true,
//                       decoration:
//                           const InputDecoration(hintText: "Repetir contraseña"),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.height * 0.08),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _saveData();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const HomePage()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(
//                           (MediaQuery.of(context).size.width * 0.75),
//                           (MediaQuery.of(context).size.height * 0.08),
//                         ),
//                       ),
//                       child: Text(
//                         "Registrarse",
//                         style: SweetCakeTheme.loginTheme.textTheme.titleLarge,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(
//                           top: MediaQuery.of(context).size.height * 0.02),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const LoginMain()));
//                         },
//                         child: Text(
//                           "Regresar",
//                           style: SweetCakeTheme.loginTheme.textTheme.bodyMedium,
//                         ),
//                       )),
//                 ],
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
