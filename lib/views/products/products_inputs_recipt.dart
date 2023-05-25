import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/supplies_form_provider.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:wholecake/theme/theme_constant.dart';
export 'package:wholecake/routes/app_routes.dart';

class InputsReciptSupplies extends StatefulWidget {
  const InputsReciptSupplies({super.key});

  @override
  _InputsReciptSuppliesState createState() => _InputsReciptSuppliesState();
}

class _InputsReciptSuppliesState extends State<InputsReciptSupplies> {
  late ProductService _productService;
  @override
  void initState() {
    super.initState();
    _productService = Provider.of<ProductService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SuppliesFormProvider(_productService.selectedSupplies!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar Insumos',
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
  @override
  Widget build(BuildContext context) {
    final suppliesForm = Provider.of<SuppliesFormProvider>(context);
    final supplies = suppliesForm.supplies;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Form(
              key: suppliesForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.04,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Producto'),
                      TextFormField(
                        initialValue: supplies.nombreinsumoSupplies.toString(),
                        onChanged: (value) =>
                            supplies.nombreinsumoSupplies = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Nombre del Insumo',
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
                        initialValue: supplies.tipoinsumoSupplies,
                        onChanged: (value) =>
                            supplies.tipoinsumoSupplies = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El tipo de insumo es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Tipo Insumo',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fecha Llegada'),
                      Theme(
                        data: SweetCakeTheme.calendarTheme,
                        child: DateTimePicker(
                          initialValue: supplies.fechallegadaSupplies,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          // onChanged: (val) => print(val),
                          validator: (val) {
                            supplies.fechallegadaSupplies = val!;
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
                          initialValue: supplies.fechavencimientoSupplies,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          // onChanged: (val) => print(val),
                          validator: (val) {
                            supplies.fechavencimientoSupplies = val!;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Estado'),
                      TextFormField(
                        initialValue: supplies.estadoSupplies,
                        onChanged: (value) => supplies.estadoSupplies = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El estado es obligatorio';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Estado del Insumo',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Marca'),
                      TextFormField(
                        initialValue: supplies.marcaproductoSupplies,
                        onChanged: (value) =>
                            supplies.marcaproductoSupplies = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La marca es obligatoria';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Marca del Insumo',
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
                        initialValue: supplies.cantidadSupplies.toString(),
                        onChanged: (value) =>
                            supplies.cantidadSupplies = value as int,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La Cantidad es obligatoria';
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Cantidad de Insumos',
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
