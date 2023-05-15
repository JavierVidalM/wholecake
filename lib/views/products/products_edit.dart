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
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _manufacturingDateController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

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
      ),
    );
    _nameController.text = product.nombre;
    _categoryController.text = product.categoria.toString();
    _priceController.text = product.precio.toString();
    _manufacturingDateController.text = product.fechaElaboracion;
    _expiryDateController.text = product.fechaVencimiento;
    _imageController.text = product.imagen;
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
      ),
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
        padding: EdgeInsets.all(16.0),
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
                    hintText: 'Nombre del producto',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha Elaboración'),
                Theme(
                  data: SweetCakeTheme.calendarTheme,
                  child: DateTimePicker(
                    initialValue: product.fechaElaboracion,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    // onChanged: (val) => print(val),
                    validator: (val) {
                      product.fechaVencimiento = val!;
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
                    // onChanged: (val) => print(val),
                    validator: (val) {
                      product.fechaVencimiento = val!;
                    },
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
                  decoration: const InputDecoration(
                    hintText: 'Nombre del producto',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Actualizar el producto
                product.nombre = _nameController.text;
                product.categoria = int.parse(_categoryController.text);
                product.precio = int.parse(_priceController.text);
                product.fechaElaboracion = _manufacturingDateController.text;
                product.fechaVencimiento = _expiryDateController.text;
                product.imagen = _imageController.text;

                productService.updateProduct(product).then((value) {
                  // Lógica después de actualizar el producto
                });
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
