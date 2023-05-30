
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders_list.dart';
import 'package:wholecake/services/ordencompra_services.dart';
import 'package:wholecake/providers/ordenes_form_provider.dart';

class PurchaseEdit extends StatefulWidget {
  // final int ordenId;

  const PurchaseEdit({Key? key}) : super(key: key);

  @override
  _PurchaseEditState createState() => _PurchaseEditState();
}

class _PurchaseEditState extends State<PurchaseEdit> {
  late OrdencompraService _ordenService;
  @override
  void initState() {
    super.initState();
    _ordenService = Provider.of<OrdencompraService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrdenesFormProvider(_ordenService.selectedOdc!),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Editar Orden de Compra',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: _ProductForm(ordenService: _ordenService),
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  final OrdencompraService ordenService;

  const _ProductForm({Key? key, required this.ordenService})
      : super(key: key);

  @override
  State<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<_ProductForm> {
  @override
  Widget build(BuildContext context) {
    final ordenForm = Provider.of<OrdenesFormProvider>(context);
    final orden = ordenForm.orden;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Form(
            key: ordenForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Cantidad'),
                      TextFormField(
                        initialValue: orden.cantidad.toString(),
                        onChanged: (value) =>
                            orden.cantidad = int.tryParse(value) ?? 0,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La cantidad es obligatoria';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Cantidad',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Costo'),
                    TextFormField(
                      initialValue: orden.costotal.toString(),
                      onChanged: (value) =>
                          orden.costotal = int.tryParse(value) ?? 0,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El costo es obligatorio';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Costo',
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
                        if (!ordenForm.isValidForm()) return;
                        await widget.ordenService.updateOrdenCompra(orden);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PurchaseList()),
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
                              builder: (context) => const PurchaseList()),
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
        ),
      ),
    );
  }
}
