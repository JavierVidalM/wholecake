import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:date_time_picker/date_time_picker.dart';

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

class _ProductForm extends StatelessWidget {
  final ProductService productService;

  const _ProductForm({Key? key, required this.productService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

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
                        initialValue: product.categoria,
                        onChanged: (value) => product.categoria = value,
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
                            product.precio = "0";
                          } else {
                            product.precio = value;
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
                          if (!productForm.isValidForm()) return;
                          await productService
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
