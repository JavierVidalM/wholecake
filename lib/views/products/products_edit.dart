import 'package:flutter/material.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/sidebar.dart';
import 'package:wholecake/ui/input_decorations.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';

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
            style: TextStyle(
              color: Color(0xFF5D2A42),
              fontSize: 24,
            ),
          ),
          backgroundColor: Color(0xFFFFB5D7),
          centerTitle: true,
          titleSpacing: 0,
        ),
        drawer: SideBar(),
        body: _ProductoScreenBody(productService: _productService),
      ),
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
      backgroundColor: Color(0xFFBDE0FE),
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
          // decoration: _createDecoration(),
          child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Producto',
                      style: TextStyle(
                        color: Color(0XFF5D2A42),
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      initialValue: product.nombre,
                      onChanged: (value) => product.nombre = value,
                      validator: (value) {
                        if (value == null || value.length < 1)
                          return 'El nombre es obligatorio';
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                        hintStyle: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categoría',
                      style: TextStyle(
                        color: Color(0XFF5D2A42),
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      initialValue: product.categoria,
                      onChanged: (value) => product.categoria = value,
                      validator: (value) {
                        if (value == null || value.length < 1)
                          return 'La categoría es obligatoria';
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                        hintStyle: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha Elaboración',
                      style: TextStyle(
                        color: Color(0XFF5D2A42),
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      initialValue: product.fechaElaboracion.toString(),
                      onChanged: (value) =>
                          product.fechaElaboracion = DateTime.parse(value),
                      validator: (value) {
                        if (value == null || value.length < 1)
                          return 'La fecha de elaboración es obligatoria';
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                        hintStyle: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha Vencimiento',
                      style: TextStyle(
                        color: Color(0XFF5D2A42),
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      initialValue: product.fechaVencimiento.toString(),
                      onChanged: (value) =>
                          product.fechaVencimiento = DateTime.parse(value),
                      validator: (value) {
                        if (value == null || value.length < 1)
                          return 'El nombre es obligatorio';
                      },
                      decoration: InputDecoration(
                        hintText: 'Nombre del producto',
                        hintStyle: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Precio',
                      style: TextStyle(
                        color: Color(0XFF5D2A42),
                        fontSize: 18,
                      ),
                    ),
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
                        hintStyle: TextStyle(
                          color: Color(0xFFA1A1A1),
                          fontSize: 14,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
