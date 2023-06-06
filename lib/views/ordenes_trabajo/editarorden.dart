// import 'package:flutter/material.dart';
// import 'package:wholecake/services/ordentrabajo_services.dart';
// import 'package:wholecake/views/utilidades/sidebar.dart';
// import 'package:provider/provider.dart';
// import 'package:wholecake/providers/suppliers_form_provider.dart';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:typed_data';
// import 'dart:convert';
// import 'dart:io';

// class OrdenEdit extends StatefulWidget {
//   @override
//   OrdenEditState createState() => OrdenEditState();
// }

// class OrdenEditState extends State<SuppliersEdit> {
//   late OrdenTrabajoService _productService;
//   @override
//   void initState() {
//     super.initState();
//     _productService = Provider.of<OrdenTrabajoService>(context, listen: false);
//   }

//   String? validateName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Por favor, ingrese el nombre del producto.';
//     }
//     final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
//     if (!nameRegExp.hasMatch(value)) {
//       return 'El nombre no debe contener números ni símbolos.';
//     }
//     return null;
//   }

//   String? validateProducto(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Por favor, ingrese el producto.';
//     }
//     final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
//     if (!nameRegExp.hasMatch(value)) {
//       return 'El producto no debe contener números ni símbolos.';
//     }
//     return null;
//   }

//   String? validateRut(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Por favor, ingrese el RUT del proveedor.';
//     }
//     final rutRegExp = RegExp(
//         r'^(\d{1,2}\.?\d{3}\.?\d{3}[-][0-9kK]{1}|[0-9]{1,2}[0-9]{3}[0-9]{3}[0-9kK]{1})$');
//     if (!rutRegExp.hasMatch(value)) {
//       return 'El RUT no es válido.';
//     }
//     return null;
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Por favor ingrese una dirección de correo electrónico';
//     }

//     final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
//     if (!emailRegExp.hasMatch(value)) {
//       return 'Por favor ingrese un correo válido';
//     }

//     return null;
//   }

//   String? validatePhoneNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Por favor, ingrese el número de teléfono.';
//     }
//     final phoneRegExp = RegExp(r'^[+]?[0-9]{10,13}$');
//     if (!phoneRegExp.hasMatch(value)) {
//       return 'El número de teléfono no es válido.';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => SupplierFormProvider(_productService.selectedSupplier!),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Editar Proveedor',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           toolbarHeight: MediaQuery.of(context).size.height * 0.1,
//         ),
//         drawer: const SideBar(),
//         body: _ProductForm(productService: _productService),
//       ),
//     );
//   }
// }

// class _ProductForm extends StatefulWidget {
//   final SuppliersService productService;

//   const _ProductForm({Key? key, required this.productService})
//       : super(key: key);

//   @override
//   State<_ProductForm> createState() => _ProductFormState();
// }

// class _ProductFormState extends State<_ProductForm> {
//   File? imageSelected;

//   Future<void> seleccionarImagen() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.image);
//     if (result != null) {
//       setState(() {
//         imageSelected = File(result.files.single.path!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final supplierForm = Provider.of<SupplierFormProvider>(context);
//     final supplier = supplierForm.supplier;
//     ImageProvider image;
//     if (imageSelected != null) {
//       image = FileImage(imageSelected!);
//     } else if (supplier.imagen_insumo.isNotEmpty) {
//       Uint8List bytes =
//           Uint8List.fromList(base64.decode(supplier.imagen_insumo));
//       image = MemoryImage(bytes);
//     } else {
//       image = const AssetImage('assets/images/default.png');
//     }
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             width: double.infinity,
//             child: Form(
//               key: supplierForm.formKey,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).size.height * 0.04,
//                     ),
//                     child: InkWell(
//                       onTap: seleccionarImagen,
//                       child: Container(
//                         width: 80.0,
//                         height: 80.0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: image,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: ClipOval(
//                           child: imageSelected != null
//                               ? Image.file(
//                                   imageSelected!,
//                                   width: 80.0,
//                                   height: 80.0,
//                                   fit: BoxFit.cover,
//                                 )
//                               : const SizedBox(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Producto'),
//                       TextFormField(
//                         initialValue: supplier.nombreProveedor,
//                         onChanged: (value) => supplier.nombreProveedor = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, ingrese el nombre del producto.';
//                           }
//                           final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
//                           if (!nameRegExp.hasMatch(value)) {
//                             return 'El nombre no debe contener números ni símbolos.';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: 'Nombre del producto',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('RUT'),
//                       TextFormField(
//                         initialValue: supplier.nombreProveedor,
//                         onChanged: (value) => supplier.rut = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, ingrese el RUT del proveedor.';
//                           }
//                           final rutRegExp = RegExp(
//                               r'^(\d{1,2}\.?\d{3}\.?\d{3}[-][0-9kK]{1}|[0-9]{1,2}[0-9]{3}[0-9]{3}[0-9kK]{1})$');
//                           if (!rutRegExp.hasMatch(value)) {
//                             return 'El RUT no es válido.';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: 'RUT',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Producto'),
//                       TextFormField(
//                         initialValue: supplier.tipoInsumo,
//                         onChanged: (value) => supplier.tipoInsumo = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, ingrese el insumo.';
//                           }
//                           final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
//                           if (!nameRegExp.hasMatch(value)) {
//                             return 'El insumo no debe contener números ni símbolos.';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: 'Insumo',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Correo del proveedor'),
//                       TextFormField(
//                         initialValue: supplier.correoProveedor,
//                         onChanged: (value) => supplier.correoProveedor = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor ingrese una dirección de correo electrónico';
//                           }

//                           final emailRegExp = RegExp(
//                               r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
//                           if (!emailRegExp.hasMatch(value)) {
//                             return 'Por favor ingrese un correo válido';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: 'Correo del proveedor',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Producto'),
//                       TextFormField(
//                         initialValue: supplier.telefonoProveedor.toString(),
//                         onChanged: (value) => supplier.nombreProveedor = value,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, ingrese el número de teléfono.';
//                           }
//                           final phoneRegExp = RegExp(r'^[+]?[0-9]{10,13}$');
//                           if (!phoneRegExp.hasMatch(value)) {
//                             return 'El número de teléfono no es válido.';
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: 'Nombre del producto',
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           final bytes = imageSelected != null
//                               ? await imageSelected!.readAsBytes()
//                               : null;
//                           final base64 =
//                               bytes != null ? base64Encode(bytes) : "";
//                           supplier.imagen_insumo = base64;
//                           if (!supplierForm.isValidForm()) return;
//                           await widget.productService.updateSupplier(supplier);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SuppliersView()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(
//                             (MediaQuery.of(context).size.width * 0.6),
//                             (MediaQuery.of(context).size.height * 0.07),
//                           ),
//                         ),
//                         child: const Text('Guardar'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const SuppliersView()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: Size(
//                             (MediaQuery.of(context).size.width * 0.6),
//                             (MediaQuery.of(context).size.height * 0.07),
//                           ),
//                         ),
//                         child: const Text('Volver'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
