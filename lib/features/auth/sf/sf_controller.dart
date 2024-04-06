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

  Future<String?> getUID(String name_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(NAME_KEY);
  }
}
