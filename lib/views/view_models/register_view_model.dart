import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/router.dart';
import 'package:flutter_assessment/services/auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  String firstName;
  String lastName;
  String email;
  String password;

  bool get isButtonEnabled =>
      (lastName?.isNotEmpty ?? false) &&
      (firstName?.isNotEmpty ?? false) &&
      (password?.isNotEmpty ?? false) &&
      (email?.isNotEmpty ?? false);

  setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  setFirstName(String firstName) {
    this.firstName = firstName;
    notifyListeners();
  }

  setLastName(String lastName) {
    this.lastName = lastName;
    notifyListeners();
  }

  onRegisterPressed() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      isLoading = true;
      notifyListeners();
      getIt<AuthService>()
          .registerUser(
              email: email,
              password: password,
              firstName: firstName,
              lastName: lastName)
          .then((_) {
        Get.offAllNamed(HomeRoute);
      }).catchError((error) {
        return Get.snackbar("Da ist wohl etwas schiefgelaufen", error);
      }).whenComplete(() {
        isLoading = false;
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  void onLoginPressed() {
    Get.back();
  }
}
