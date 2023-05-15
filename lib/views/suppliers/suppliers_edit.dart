import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/suppliers_form_provider.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class SuppliersEdit extends StatefulWidget {
  @override
  _SuppliersEditState createState() => _SuppliersEditState();
}

class _SuppliersEditState extends State<SuppliersEdit> {
  late ProductService _productService;
  @override
  void initState() {
    super.initState();
    _productService = Provider.of<ProductService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SupplierFormProvider(_productService.selectedSupplier!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar Proveedor',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: _ProductForm(productService: _productService),
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  final ProductService productService;

  const _ProductForm({Key? key, required this.productService})
      : super(key: key);

  @override
  State<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<_ProductForm> {
  File? imageSelected;

  Future<void> seleccionarImagen() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        imageSelected = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final supplierForm = Provider.of<SupplierFormProvider>(context);
    final supplier = supplierForm.supplier;
    ImageProvider image;
    if (imageSelected != null) {
      image = FileImage(imageSelected!);
    } else if (supplier.imagen_insumo.isNotEmpty) {
      Uint8List bytes =
          Uint8List.fromList(base64.decode(supplier.imagen_insumo!));
      image = MemoryImage(bytes);
    } else {
      image = const AssetImage('assets/images/default.png');
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Form(
              key: supplierForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.04,
                    ),
                    child: InkWell(
                      onTap: seleccionarImagen,
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipOval(
                          child: imageSelected != null
                              ? Image.file(
                                  imageSelected!,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Producto'),
                      TextFormField(
                        initialValue: supplier.nombreProveedor,
                        onChanged: (value) => supplier.nombreProveedor = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nombre del producto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('RUT'),
                      TextFormField(
                        initialValue: supplier.nombreProveedor,
                        onChanged: (value) => supplier.rut = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El RUT es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'RUT',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Producto'),
                      TextFormField(
                        initialValue: supplier.tipoInsumo,
                        onChanged: (value) => supplier.tipoInsumo = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El tipo de insumo es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Insumo',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Producto'),
                      TextFormField(
                        initialValue: supplier.correoProveedor,
                        onChanged: (value) => supplier.correoProveedor = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El correo es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Correo del proveedor',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Producto'),
                      TextFormField(
                        initialValue: supplier.telefonoProveedor.toString(),
                        onChanged: (value) => supplier.nombreProveedor = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nombre del producto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final bytes = imageSelected != null
                              ? await imageSelected!.readAsBytes()
                              : null;
                          final base64 =
                              bytes != null ? base64Encode(bytes) : "";
                          supplier.imagen_insumo = base64;
                          if (!supplierForm.isValidForm()) return;
                          await widget.productService.updateSupplier(supplier);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuppliersView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            (MediaQuery.of(context).size.width * 0.6),
                            (MediaQuery.of(context).size.height * 0.07),
                          ),
                        ),
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuppliersView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            (MediaQuery.of(context).size.width * 0.6),
                            (MediaQuery.of(context).size.height * 0.07),
                          ),
                        ),
                        child: const Text('Volver'),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
