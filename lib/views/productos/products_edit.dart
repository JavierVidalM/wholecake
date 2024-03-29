// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../../models/categoria.dart';

import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/views/utilidades/sidebar.dart';

class ProductsEdit extends StatefulWidget {
  final int productId;

  const ProductsEdit({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductsEditState createState() => _ProductsEditState();
}

class _ProductsEditState extends State<ProductsEdit> {
  final TextEditingController _categoryController = TextEditingController();

  File? imageSelected;

  Future<void> seleccionarImagen() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        imageSelected = File(result.files.single.path!);
      });
    }
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione una categoría.';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre del producto.';
    }
    final nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el precio del producto.';
    }
    final priceRegExp = RegExp(r'^\d+(\.\d+)?$');
    if (!priceRegExp.hasMatch(value)) {
      return 'El precio debe ser un número válido.';
    }
    final price = double.parse(value);
    if (price < 0) {
      return 'El precio no puede ser negativo.';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese la cantidad del producto.';
    }
    final quantityRegExp = RegExp(r'^\d+$');
    if (!quantityRegExp.hasMatch(value)) {
      return 'La cantidad debe ser un número entero.';
    }
    final quantity = int.parse(value);
    if (quantity < 0) {
      return 'La cantidad no puede ser negativa.';
    }
    return null;
  }

  String? validateExpirationDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione una fecha de vencimiento.';
    }
    final selectedDate = DateFormat('yyyy-MM-dd').parse(value);
    final currentDate = DateTime.now();
    if (selectedDate.isBefore(currentDate)) {
      return 'La fecha de vencimiento no puede ser anterior a la fecha actual.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final product = productService.listadoproductos.firstWhere(
      (product) => product.productoId == widget.productId,
      orElse: () => Listado(
          productoId: 0,
          nombre: '',
          fechaElaboracion: '',
          fechaVencimiento: '',
          precio: 0,
          categoria: 0,
          imagen: '',
          estado: '',
          cantidad: 0,
          lote: ''),
    );
    ImageProvider image;
    if (imageSelected != null) {
      image = FileImage(imageSelected!);
    } else if (product.imagen.isNotEmpty) {
      Uint8List bytes = Uint8List.fromList(base64.decode(product.imagen));
      image = MemoryImage(bytes);
    } else {
      image = const AssetImage('assets/images/default.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar producto',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  initialValue: product.nombre,
                  onChanged: (value) => product.nombre = value,
                  validator: validateName,
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
                SizedBox(
                  child: Consumer<ProductService>(
                    builder: (context, listacat, _) {
                      ListElement? categoriaSeleccionada;
                      return DropdownButtonFormField<ListElement>(
                        validator: (ListElement? value) =>
                            validateCategory(value?.nombre),
                        hint: const Text('Selecciona una categoría'),
                        value: categoriaSeleccionada,
                        onChanged: (ListElement? nuevaCategoria) {
                          setState(() {
                            _categoryController.text =
                                nuevaCategoria!.categoriaId.toString();
                            product.categoria = nuevaCategoria
                                .categoriaId; // Agregar esta línea
                          });
                        },
                        items: listacat.listadocategorias.map((categoria) {
                          return DropdownMenuItem<ListElement>(
                            value: categoria,
                            child: Text(categoria.nombre),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha Vencimiento'),
                Theme(
                  data: SweetCakeTheme.calendarTheme,
                  child: DateTimePicker(
                    initialValue: product.fechaElaboracion,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (value) => product.fechaVencimiento = value,
                    validator: validateExpirationDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cantidad'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: product.cantidad.toString(),
                  onChanged: (value) {
                    if (int.tryParse(value) == null) {
                      product.cantidad = 0;
                    } else {
                      product.cantidad = int.parse(value);
                    }
                  },
                  validator: validateQuantity,
                  decoration: const InputDecoration(
                    hintText: 'Cantidad',
                  ),
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
                  validator: validatePrice,
                  decoration: const InputDecoration(
                    hintText: 'Precio del producto',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final bytes = imageSelected != null
                    ? await imageSelected!.readAsBytes()
                    : null;
                final base64 = bytes != null ? base64Encode(bytes) : "";
                if (imageSelected != null) {
                  product.imagen = base64;
                }
                await productService.editOrCreateProduct(product);
                // print(product.toJson());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductsView()),
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
      ),
    );
  }
}
