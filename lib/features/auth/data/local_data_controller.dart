import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataController extends GetxController {
  var isLoading = false.obs;
  var clientName = ''.obs;
  static const NAME_KEY = 'Name';

  void onInit() async {
    clientName.value = (await getUID(NAME_KEY))!;
    super.onInit();
  }

  Future<void> saveUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName.value = uid;
    prefs.setString(NAME_KEY, uid);
  }

  Future<void> saveId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName.value = id;
    prefs.setString('Id', id);
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName.value = email;
    prefs.setString('Email', email);
  }

  Future<void> deleteUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName.value = '';
    prefs.remove(NAME_KEY);
  }

  Future<void> deleteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName.value = '';
    prefs.remove('Id');
  }

  Future<void> deleteEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientName.value = '';
    prefs.remove('Email');
  }

  Future<String?> getUID(String name_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(NAME_KEY);
  }

  Future<String?> getId(String name_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(NAME_KEY);
  }

  Future<String?> getEmail(String name_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(NAME_KEY);
  }
}
