import 'package:flutter/material.dart';
import 'package:wholecake/constants.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/ui/input_decorations.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';

import 'package:flutter/material.dart';

class ProductsEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editar producto',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFB5D7), // Color rosa
        ),
      ),
      home: EditProductPage(),
    );
  }
}

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos de texto
  TextEditingController _nameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _manufactureDateController = TextEditingController();
  TextEditingController _expirationDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBDE0FE),
      appBar: AppBar(
        title: Text('Editar producto'),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.0),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _manufactureDateController,
                decoration: InputDecoration(
                  labelText: 'Fecha de elaboración',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _manufactureDateController,
                decoration: InputDecoration(
                  labelText: 'Fecha de vencimiento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB5D7),
                    ),
                    child: Text(
                      'Actualizar foto',
                      style: TextStyle(color: Color(0xFF5D2A42)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB5D7),
                    ),
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: Color(0xFF5D2A42)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                        0xFFFFB5D7,
                      ),
                    ),
                    child: Text(
                      'Volver',
                      style: TextStyle(color: Color(0xFF5D2A42)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
