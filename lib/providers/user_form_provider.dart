import 'package:flutter/material.dart';

import 'package:wholecake/models/users.dart';

class UsersFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Listado user;
  UsersFormProvider(this.user);

  bool isLoading = false;
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
