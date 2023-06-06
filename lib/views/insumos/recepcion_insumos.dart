import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../services/supplies_services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/supplies.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/providers/supplies_form_provider.dart';
import 'package:wholecake/theme/theme_constant.dart';
export 'package:wholecake/routes/app_routes.dart';
import 'package:wholecake/views/insumos/insumos.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

List<String> estadoOptions = ['En progreso', 'Correcto'];

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
    _suppliesService = Provider.of<SuppliesService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _suppliesService = Provider.of<SuppliesService>(context);
    return ChangeNotifierProvider(
      create: (_) => SuppliesFormProvider(_suppliesService.selectedSupplies!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Recepción Insumos',
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
  File? imageSelected;
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre del Insumo.';
    }
    if (value.length <= 2) {
      return 'El Producto debe tener 3 o más caracteres.';
    }
    return null;
  }

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese los datos correspondientes.';
    }
    return null;
  }

  String? validate0(String? value) {
    if (value == null || value.isEmpty) {
      return 'El Insumo debe tener 1 o más caracteres.';
    }
    final parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue <= 0) {
      return 'El valor debe ser mayor o igual a 1.';
    }
    return null;
  }

  String? validateFechallegada(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese los datos correspondientes.';
    }

    final currentDate = DateTime.now();
    final selectedDate = DateTime.parse(value);

    if (selectedDate.isAtSameMomentAs(currentDate)) {
      return 'La fecha de llegada no puede ser la misma que la fecha actual.';
    }

    return null;
  }

  Future<void> seleccionarImagen() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        imageSelected = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final suppliesForm = Provider.of<SuppliesFormProvider>(context);
    final supplies = suppliesForm.supplies;
    String? validateExpirationDate(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor, ingrese los datos correspondientes.';
      }

      final currentDate = DateTime.now();
      final selectedDate = DateTime.parse(value);

      if (selectedDate.isAtSameMomentAs(currentDate)) {
        return 'La fecha de vencimiento no puede ser la misma que la fecha actual.';
      }

      final arrivalDate = DateTime.parse(supplies.fechaLlegada);

      if (selectedDate.isAtSameMomentAs(arrivalDate)) {
        return 'La fecha de vencimiento no puede ser la misma que la fecha de llegada.';
      }

      return null;
    }

    String? validateFechallegada(String? value) {
      if (value == null || value.isEmpty) {
        return 'Por favor, ingrese los datos correspondientes.';
      }

      final selectedDate = DateTime.parse(value);

      // Obtener la fecha de vencimiento actual
      final expirationDate = DateTime.parse(supplies.fechaVencimiento);

      if (selectedDate.isAtSameMomentAs(DateTime.now())) {
        return 'La fecha de llegada no puede ser la misma que la fecha actual.';
      }

      if (selectedDate.isAtSameMomentAs(expirationDate)) {
        return 'La fecha de llegada no puede ser la misma que la fecha de vencimiento.';
      }

      return null;
    }

    ImageProvider image;
    if (imageSelected != null) {
      image = FileImage(imageSelected!);
    } else if (supplies.imagen_supplies.isNotEmpty) {
      Uint8List bytes =
          Uint8List.fromList(base64.decode(supplies.imagen_supplies));
      image = MemoryImage(bytes);
    } else {
      image = const AssetImage('assets/images/default.jpg');
    }
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
                        validator: validateName,
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
                          validator: validateFechallegada,
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
                          validator: validateExpirationDate,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Estado'),
                      DropdownButtonFormField<String>(
                        value: supplies.estado,
                        onChanged: (value) => supplies.estado = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, seleccione el cargo del empleado.';
                          }
                          return null;
                        },
                        items: estadoOptions.map((estado) {
                          return DropdownMenuItem<String>(
                            value: estado,
                            child: Text(estado),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          hintText: 'Estado',
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
                        validator: validateName,
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
                        keyboardType: TextInputType.number,
                        initialValue: supplies.cantidad.toString(),
                        onChanged: (value) {
                          if (int.tryParse(value) == null) {
                            supplies.cantidad = 0;
                          } else {
                            supplies.cantidad = int.parse(value);
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Cantidad de Insumos',
                        ),
                        validator: validate0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final bytes = imageSelected != null
                              ? await imageSelected!.readAsBytes()
                              : null;
                          final base64 =
                              bytes != null ? base64Encode(bytes) : "";
                          supplies.imagen_supplies = base64;
                          if (!suppliesForm.isValidForm()) return;
                          await widget.suppliesService.updateSupplies(supplies);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListadoInsumos()),
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
                                builder: (context) => const ListadoInsumos()),
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
