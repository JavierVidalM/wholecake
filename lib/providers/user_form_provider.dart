import 'package:flutter/material.dart';

import 'package:wholecake/models/users.dart';

class UsersFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List userslist;
  UsersFormProvider(this.userslist);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
