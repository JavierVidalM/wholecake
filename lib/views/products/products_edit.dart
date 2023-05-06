import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';
import 'package:wholecake/views/products/products.dart';

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
        drawer: SideBar(),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Producto'),
                    TextFormField(
                      initialValue: product.nombre,
                      onChanged: (value) => product.nombre = value,
                      validator: (value) {
                        if (value == null || value.length < 1)
                          return 'El nombre es obligatorio';
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categoría'),
                    TextFormField(
                      initialValue: product.categoria,
                      onChanged: (value) => product.categoria = value,
                      validator: (value) {
                        if (value == null || value.length < 1)
                          return 'La categoría es obligatoria';
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fecha Elaboración'),
                    TextFormField(
                      initialValue:
                          product.fechaElaboracion.toString().substring(0, 10),
                      validator: (value) {
                        if (value == null)
                          return 'La fecha de elaboración es obligatoria';

                        if (DateTime.tryParse(value) == null) {
                          return 'El valor debe ser una fecha válida';
                        } else {
                          product.fechaElaboracion = DateTime.parse(value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fecha Vencimiento'),
                    TextFormField(
                      initialValue:
                          product.fechaVencimiento.toString().substring(0, 10),
                      validator: (value) {
                        if (value == null)
                          return 'La fecha de vencimiento es obligatoria';

                        if (DateTime.tryParse(value) == null) {
                          return 'El valor debe ser una fecha válida';
                        } else {
                          product.fechaVencimiento = DateTime.parse(value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precio'),
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
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                      child: Text('Guardar'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
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
                      child: Text('Volver'),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
