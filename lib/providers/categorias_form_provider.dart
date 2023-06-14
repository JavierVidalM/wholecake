// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:wholecake/models/categoria.dart';

class CategoriaFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ListElement categoria;
  CategoriaFormProvider(this.categoria);

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
