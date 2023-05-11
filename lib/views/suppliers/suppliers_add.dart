// import 'package:flutter/material.dart';
// import 'package:wholecake/services/users_services.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:wholecake/views/utilities/sidebar.dart';
// import 'package:wholecake/theme/theme.dart';
// import 'package:wholecake/views/home/home.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:wholecake/views/users/users_list.dart';

//   @override
//   Widget build(BuildContext context) {
//     return const SuppliersAddPage();
//   }
// }

// class SuppliersAddPage extends StatefulWidget {
//   const SuppliersAddPage({Key? key}) : super(key: key);

//   @override
//   _SuppliersAddPageState createState() => _SuppliersAddPageState();
// }

// class _SuppliersAddPageState extends State<SuppliersAddPage> {
//   TextEditingController rutproveedorController = TextEditingController();
//   TextEditingController nombreproveedorController = TextEditingController();
//   TextEditingController tipoproductoController = TextEditingController();
//   TextEditingController correoproveedorController =TextEditingController();
//   TextEditingController numerotelefonoController = TextEditingController();

//   @override
//   void dispose() {
//     rutproveedorController.dispose();
//     nombreproveedorController.dispose();
//     tipoproductoController.dispose();
//     correoproveedorController.dispose();
//     numerotelefonoController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveData() async {
//     final msg = jsonEncode({
//       'rut': rutproveedorController.text,
//       'nombre_proveedor': nombreproveedorController.text,
//       'tipo_producto': tipoproductoController.text,
//       'correo_proveedor': correoproveedorController.text,
//       'numero_telefono': numerotelefonoController.text,
//     });
//     await SuppliersService().SuppliersAdd(msg);
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => SuppliersList()));
//   }
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     theme: SweetCakeTheme.mainTheme,
//     home: Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Listado de usuarios',
//           style: TextStyle(
//             color: Color(0xFF5D2A42),
//             fontSize: 24,
//           ),
//         ),
//         backgroundColor: const Color(0xFFFFB5D7),
//         centerTitle: true,
//         titleSpacing: 0,
//       ),
//       drawer: const SideBar(),
//       body: SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).size.height * 0.02,
//             ),
//             child: InkWell(
//               onTap: () async {
//                 final result = await FilePicker.platform.pickFiles(
//                   type: FileType.image
//                 );
//                 if (result != null) {
//                   setState(() {
//                     imagen = File(result.files.single.path!);
//                       });
//                 }                
//               },
//               child: Container(
//                   width: 80.0,
//                   height: 80.0,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xFF909090),
//                   ),
//                   child: ClipOval(
//                     child: imagen != null
//                         ? Image.file(
//                             imagen!,
//                             width: 80.0,
//                             height: 80.0,
//                             fit: BoxFit.cover,
//                           )
//                         : const Icon(
//                             Icons.add,
//                             size: 40.0,
//                             color: Color(0xFFC0C0C0),
//                           ),
//                   ),
//                 ),  
//             ),
//           ),
//           TextFormField(
//             controller: nombreproveedorController,
//             decoration: const InputDecoration(hintText: 'Nombre Proveedor'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),  
//           TextFormField(
//             controller: rutproveedorController,
//             decoration: const InputDecoration(hintText: 'Rut Proveedor'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             controller: tipoproductoController,
//             decoration: const InputDecoration(hintText: 'Tipo de Producto'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             controller: correoproveedorController,
//             decoration: const InputDecoration(hintText: 'Correo Proveedor'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           TextFormField(
//             controller: numerotelefonoController,
//             decoration: const InputDecoration(hintText: 'Número de Teléfono'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//           onPressed: () {
//             _saveData();
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const HomePage()));
//           },
//           style: ElevatedButton.styleFrom(
//             minimumSize: Size(
//               (MediaQuery.of(context).size.width * 0.6),
//               (MediaQuery.of(context).size.height * 0.07),
//             ),
//           ),
//           child: const Text('Guardar'),
//         ),
//           const SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const HomePage()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               minimumSize: Size(
//                 (MediaQuery.of(context).size.width * 0.6),
//                 (MediaQuery.of(context).size.height * 0.07),
//               ),
//             ),
//             child: const Text('Volver'),
//           ),                                     
//         ],
//     ),
//     ),
//   ));
// }
// }