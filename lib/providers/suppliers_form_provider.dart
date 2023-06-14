// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:wholecake/models/suppliers.dart';

class SupplierFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ListSup supplier;
  SupplierFormProvider(this.supplier);

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
