import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/models/ordendecompra.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/utilities/sidebar.dart';

import '../../models/categoria.dart';
import '../../theme/theme_constant.dart';

class PurchaseOrders extends StatefulWidget {
  @override
  _PurchaseOrdersState createState() => _PurchaseOrdersState();
}

class _PurchaseOrdersState extends State<PurchaseOrders> {
  TextEditingController suppliersController = TextEditingController();
  String dropdownValue = 'Selecciona un proveedor';

  @override
  void dispose() {
    suppliersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ordenes de compra',
          style: Theme.of(context).textTheme.headline6,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: SideBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: Theme(
                data: SweetCakeTheme.calendarTheme,
                child: DateTimePicker(
                  dateHintText: 'Fecha',
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Tipo de Producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Marca del Producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Cantidad del Producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Costo por unidad'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Costo Total'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'Selecciona un proveedor',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Selecciona un proveedor',
                  'Proveedor1',
                  'Weon 2',
                  'Weon3'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                  child: const Text('Realizar orden'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.07,
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
