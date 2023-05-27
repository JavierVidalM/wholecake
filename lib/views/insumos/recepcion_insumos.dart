import 'package:flutter/material.dart';
import '../../services/supplies_services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/providers/supplies_form_provider.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:wholecake/views/proveedores/suppliers_view.dart';
import 'package:wholecake/theme/theme_constant.dart';
export 'package:wholecake/routes/app_routes.dart';

class InputsReciptSupplies extends StatefulWidget {
  const InputsReciptSupplies({super.key});

  @override
  _InputsReciptSuppliesState createState() => _InputsReciptSuppliesState();
}

class _InputsReciptSuppliesState extends State<InputsReciptSupplies> {
  late SuppliesService _suppliesService;
  @override
  void initState() {
    super.initState();
    _suppliesService = Provider.of<SuppliesService>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SuppliesFormProvider(_suppliesService.selectedSupplies!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar Insumos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: _ProductForm(suppliesService: _suppliesService),
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  final SuppliesService suppliesService;

  const _ProductForm({Key? key, required this.suppliesService})
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
                        initialValue: supplies.nombreInsumo.toString(),
                        onChanged: (value) => supplies.nombreInsumo = value,
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
                        initialValue: supplies.tipoInsumo,
                        onChanged: (value) => supplies.tipoInsumo = value,
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
                          initialValue: supplies.fechaLlegada,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          // onChanged: (val) => print(val),
                          validator: (val) {
                            supplies.fechaLlegada = val!;
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
                          initialValue: supplies.fechaVencimiento,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          // onChanged: (val) => print(val),
                          validator: (val) {
                            supplies.fechaVencimiento = val!;
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
                        initialValue: supplies.estado,
                        onChanged: (value) => supplies.estado = value,
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
                        initialValue: supplies.marcaProducto,
                        onChanged: (value) => supplies.marcaProducto = value,
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
                        initialValue: supplies.cantidad.toString(),
                        onChanged: (value) => supplies.cantidad = value as int,
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
