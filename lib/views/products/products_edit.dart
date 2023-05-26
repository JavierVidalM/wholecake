import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/views/utilities/sidebar.dart';

class ProductsEdit extends StatefulWidget {
  final int productId;

  const ProductsEdit({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductsEditState createState() => _ProductsEditState();
}

class _ProductsEditState extends State<ProductsEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  File? imageSelected;
  final _formKey = GlobalKey<FormState>();

  Future<void> seleccionarImagen() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        imageSelected = File(result.files.single.path!);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadProductDetails();
  }

  void loadProductDetails() {
    final productService = Provider.of<ProductService>(context, listen: false);
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
    _nameController.text = product.nombre;
    _categoryController.text = product.categoria.toString();
    _quantityController.text = product.precio.toString();
    _priceController.text = product.precio.toString();
    _expiryDateController.text = product.fechaVencimiento;
    _imageController.text = product.imagen;
  }

  void updateProductDetails() {
    final productService = Provider.of<ProductService>(context, listen: false);
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
    product.nombre = _nameController.text;
    product.categoria = int.parse(_categoryController.text);
    product.precio = int.parse(_priceController.text);
    product.fechaVencimiento = _expiryDateController.text;

    if (_formKey.currentState!.validate()) {
      // Save the updated product to the database
      productService.updateProduct(product);

      // Navigate back to the products view
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductsView()),
      );
    }
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
        child: Form(
          key: _formKey,
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
                    controller: _nameController,
                    onChanged: (value) => product.nombre = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es obligatorio';
                      } else if (_containsNumbersOrSpecialCharacters(value)) {
                        return 'El nombre no debe contener números ni caracteres especiales';
                      }
                      return null;
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
                    controller: _categoryController,
                    onChanged: (value) => product.categoria = int.parse(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La categoría es obligatoria';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Categoría',
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
                      controller: _expiryDateController,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      validator: (val) {
                        product.fechaVencimiento = val!;
                        if (val.isEmpty) {
                          return 'La fecha de vencimiento es obligatoria';
                        }
                        return null;
                      },
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
                    controller: _quantityController,
                    onChanged: (value) {
                      if (_isNumeric(value)) {
                        product.cantidad = int.parse(value);
                      } else {
                        product.cantidad = 0;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La cantidad es obligatoria';
                      } else if (!_isNumeric(value)) {
                        return 'La cantidad debe ser un número';
                      } else if (int.parse(value) < 0) {
                        return 'La cantidad no puede ser negativa';
                      }
                      return null;
                    },
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
                    controller: _priceController,
                    onChanged: (value) {
                      if (_isNumeric(value)) {
                        product.precio = int.parse(value);
                      } else {
                        product.precio = 0;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El precio es obligatorio';
                      } else if (!_isNumeric(value)) {
                        return 'El precio debe ser un número';
                      } else if (int.parse(value) < 0) {
                        return 'El precio no puede ser negativo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Precio',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProductDetails();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        (MediaQuery.of(context).size.width * 0.4),
                        (MediaQuery.of(context).size.height * 0.07),
                      ),
                    ),
                    child: const Text('Guardar'),
                  ),
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
                        (MediaQuery.of(context).size.width * 0.4),
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
      ),
    );
  }

  bool _isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  bool _containsNumbersOrSpecialCharacters(String value) {
    final pattern = RegExp(r'[0-9@#^&*()\[\]{}\-?_+=%$]');
    return pattern.hasMatch(value);
  }
}
