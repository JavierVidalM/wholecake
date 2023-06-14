// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:wholecake/models/ordendecompra.dart';

class OrdenesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ListOdc orden;
  OrdenesFormProvider(this.orden);

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
