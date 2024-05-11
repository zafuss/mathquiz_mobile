import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataController extends GetxController {
  var isLoading = false.obs;
  var clientFullName = ''.obs;
  var clientEmail = ''.obs;
  var clientId = ''.obs;

  @override
  onInit() async {
    clientFullName.value = await getClientFullName() ?? 'null';
    clientEmail.value = await getClientEmail() ?? 'null';
    clientId.value = await getClientId() ?? 'null';
    super.onInit();
  }

  Future<void> saveClientId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientId.value = id;
    prefs.setString('clientId', id);
  }

  Future<void> saveClientFullName(String fullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientFullName.value = fullName;
    prefs.setString('clientFullName', fullName);
  }

  Future<void> saveClientEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientEmail.value = email;
    prefs.setString('clientEmail', email);
  }

  Future<void> deleteClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientId.value = '';
    prefs.remove('clientId');
  }

  Future<void> deleteClientFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientFullName.value = '';
    prefs.remove('clientFullName');
  }

  Future<void> deleteClientEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientEmail.value = '';
    prefs.remove('clientEmail');
  }

  Future<String?> getClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientId');
  }

  Future<String?> getClientFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientFullName');
  }

  Future<String?> getClientEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientEmail');
  }
}
