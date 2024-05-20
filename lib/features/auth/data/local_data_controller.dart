import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataController extends GetxController {
  var isLoading = false.obs;
  var clientFullName = ''.obs;
  var clientEmail = ''.obs;
  var clientId = ''.obs;
  var registerClientId = ''.obs;
  var clientImageUrl = ''.obs;
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

  Future<void> saveRegisterClientId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    registerClientId.value = id;
    prefs.setString('registerClientId', id);
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

  Future<void> saveClientImageUrl(String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientImageUrl.value = imageUrl;
    prefs.setString('clientImageUrl', imageUrl);
  }

  Future<void> deleteClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientId.value = '';
    prefs.remove('clientId');
  }

  Future<void> deleteRegisterClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    registerClientId.value = '';
    prefs.remove('registerClientId');
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

  Future<void> deleteClientImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientImageUrl.value = '';
    prefs.remove('clientImageUrl');
  }

  Future<String?> getClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientId');
  }

  Future<String?> getRegisterClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('registerClientId');
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

Future<String?> getClientImageUrl() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('clientImageUrl');
}
