import 'package:flutter/material.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/ui/input_decorations.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';

class ProductsEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductoScreenBody(productService: productService),
    );
  }
}

class _ProductoScreenBody extends StatelessWidget {
  const _ProductoScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          _ProductForm(),
          const SizedBox(height: 100),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_outlined),
          onPressed: () async {
            if (!productForm.isValidForm()) return;
            print(productForm.product);

            await productService.editOrCreateProduct(productForm.product);
          }),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.nombre,
                  onChanged: (value) => product.nombre = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligtorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del producto', labelText: 'Nombre'),
                ),
                TextFormField(
                  initialValue: product.categoria,
                  onChanged: (value) => product.categoria = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligtorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Categoria', labelText: 'categoria'),
                ),
                TextFormField(
                  initialValue: product.fechaElaboracion.toString(),
                  onChanged: (value) =>
                      product.fechaElaboracion = DateTime.parse(value),
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligtorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Fecha Elaboracion',
                      labelText: 'fecha elaboracion'),
                ),
                TextFormField(
                  initialValue: product.fechaVencimiento.toString(),
                  onChanged: (value) =>
                      product.fechaVencimiento = DateTime.parse(value),
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligtorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Fecha Vencimiento',
                      labelText: 'Fecha vencimiento'),
                ),
                const SizedBox(height: 20),
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
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$15000', labelText: 'Precio'),
                ),
                const SizedBox(height: 20),
                SwitchListTile.adaptive(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.orange,
                  title: const Text('Disponible'),
                )
              ],
            )),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
