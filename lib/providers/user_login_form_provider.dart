import 'package:flutter/material.dart';

// import 'package:wholecake/models/users_login.dart';

class UsersLoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Listado userslist;
  // UsersFormProvider(this.userslist);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
