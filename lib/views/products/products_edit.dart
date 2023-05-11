import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

class ProductsEdit extends StatefulWidget {
  @override
  _ProductsEditState createState() => _ProductsEditState();
}

class _ProductsEditState extends State<ProductsEdit> {
  late ProductService _productService;
  @override
  void initState() {
    super.initState();
    _productService = Provider.of<ProductService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(_productService.selectedProduct!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar producto',
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
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    ImageProvider image;
    if (imageSelected != null) {
      image = FileImage(imageSelected!);
    } else if (product.imagen.isNotEmpty) {
      Uint8List bytes = Uint8List.fromList(base64.decode(product.imagen));
      image = MemoryImage(bytes);
    } else {
      image = AssetImage('assets/images/placeholder-image.png');
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Form(
              key: productForm.formKey,
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
                      Text('Producto'),
                      TextFormField(
                        initialValue: product.nombre,
                        onChanged: (value) => product.nombre = value,
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
                      const Text('Categoría'),
                      TextFormField(
                        initialValue: product.categoria.toString(),
                        onChanged: (value) => product.categoria = int.parse(value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La categoría es obligatoria';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Categoria del producto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fecha Elaboración'),
                      DateTimePicker(
                        initialValue: product.fechaElaboracion,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        // onChanged: (val) => print(val),
                        validator: (val) {
                          product.fechaVencimiento = val!;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fecha Vencimiento'),
                      DateTimePicker(
                        initialValue: product.fechaElaboracion,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        // onChanged: (val) => print(val),
                        validator: (val) {
                          product.fechaVencimiento = val!;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Precio'),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: product.precio.toString(),
                        onChanged: (value) {
                          if (int.tryParse(value) == null) {
                            product.precio = 0;
                          } else {
                            product.precio = int.parse(value);
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
                          product.imagen = base64;
                          if (!productForm.isValidForm()) return;
                          await widget.productService
                              .editOrCreateProduct(productForm.product);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductsView()),
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
                                builder: (context) => const ProductsView()),
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
