// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wholecake/models/users.dart';
// import 'package:wholecake/views/users/users.dart';
// import 'package:wholecake/services/users_services.dart';
// import 'package:wholecake/providers/user_form_provider.dart';
// import '../utilities/sidebar.dart';

// class UsersList extends StatefulWidget {
//   const UsersList({Key? key}) : super(key: key);

//   @override
//   _UsersListState createState() => _UsersListState();
// }

// class _UsersListState extends State<UsersList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xFFBDE0FE),
//         appBar: AppBar(
//           title: const Text(
//             'Listado de usuarios',
//             style: TextStyle(
//               color: Color(0xFF5D2A42),
//               fontSize: 24,
//             ),
//           ),
//           backgroundColor: const Color(0xFFFFB5D7),
//           centerTitle: true,
//           titleSpacing: 0,
//         ),
//         drawer: const SideBar(),
//         body: Consumer<UserService>(builder: (context, listado, child) {
//           return Column(children: [
//             Container(
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.only(right: 20.0, top: 5),
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const UsersAdd()));
//                 },
//                 label: const Text(
//                   'Agregar',
//                   style: TextStyle(color: Color(0xFF5D2A42)),
//                 ),
//                 icon: const Icon(
//                   Icons.add,
//                   color: Color(0xFF5D2A42),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFFB5D7),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: listado.userslist.length,
//                 itemBuilder: (context, index) {
//                   final user = listado.userslist[index];
//                   Uint8List bytes =
//                       Uint8List.fromList(base64.decode(user.userImagen));
//                   Image image = Image.memory(bytes);
//                   return Card(
//                     color: const Color(0xFFBDE0FE),
//                     elevation: 10,
//                     margin: EdgeInsets.symmetric(
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                         horizontal: MediaQuery.of(context).size.width * 0.04),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             margin: const EdgeInsets.only(right: 10, top: 10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               shape: BoxShape.rectangle,
//                               image: DecorationImage(
//                                 image: image.image,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(width: 10),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       user.userName,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         IconButton(
//                                           onPressed: () {
//                                             listado.selectedUser =
//                                                 listado.userslist[index].copy();
//                                             print(
//                                                 'este es el listado de usuarios');
//                                             print(listado.selectedUser);
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const UsersEdit()),
//                                             );
//                                           },
//                                           icon: const Icon(Icons.edit),
//                                         ),
//                                         IconButton(
//                                           onPressed: () async {
//                                             final msg =
//                                                 jsonEncode({'id': user.userId});
//                                             await UserService()
//                                                 .UsersDelete(msg);
//                                             setState(() {
//                                               listado.userslist.removeAt(index);
//                                             });
//                                           },
//                                           icon: const Icon(Icons.delete),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   'Cargo: ${user.userCargo.toString().substring(0, 10)}',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   'Sede: ${user.userSede.toString().substring(0, 10)}',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   user.userId.toString(),
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ]);
//         }));
//   }
// }
