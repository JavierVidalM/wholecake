import 'package:flutter/material.dart';
import 'package:wholecake/models/supplies.dart';

class SuppliesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  ListSupplies supplies;
  SuppliesFormProvider(this.supplies);

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
