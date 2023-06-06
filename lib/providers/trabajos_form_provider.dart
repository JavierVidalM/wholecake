import 'package:flutter/material.dart';
import 'package:wholecake/models/ordendetrabajo.dart';

class ordenTrabajoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ListTrabajo ordentrabajo;
  ordenTrabajoFormProvider(this.ordentrabajo);

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
