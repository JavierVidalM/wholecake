import 'package:flutter/material.dart';
import 'package:wholecake/models/ventas.dart';

class VentasFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Listventa ventas;
  VentasFormProvider(this.ventas);

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
