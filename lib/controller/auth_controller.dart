import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;

  updateLoading(bool v){
    loading.value =v;
    update();
  }


    // validator
  final requiredValidator = RequiredValidator(errorText: 'Required');
  final emailValidator =
      EmailValidator(errorText: 'Enter a valid email address');
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
  ]);
}