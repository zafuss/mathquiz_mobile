import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataController extends GetxController {
  var isLoading = false.obs;
  var clientFullName = ''.obs;
  var clientEmail = ''.obs;
  var clientId = ''.obs;
  var registerClientId = ''.obs;
  var clientImageUrl = ''.obs;
  var clientAccessToken = ''.obs;
  var clientRefreshToken = ''.obs;
  var clientPhoneNumber = ''.obs;
  var isRememberMe = false.obs;
  RxInt clientGradeId = (-1).obs;
  @override
  onInit() async {
    clientFullName.value = await getClientFullName() ?? 'null';
    clientEmail.value = await getClientEmail() ?? 'null';
    clientId.value = await getClientId() ?? 'null';
    isRememberMe.value = await getIsRememberMe() ?? false;
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

  Future<void> saveClientAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientAccessToken.value = accessToken;
    prefs.setString('clientAccessToken', accessToken);
  }

  Future<void> saveClientRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientRefreshToken.value = refreshToken;
    prefs.setString('clientRefreshToken', refreshToken);
  }

  Future<void> saveClientPhoneNumber(String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientPhoneNumber.value = phoneNumber;
    prefs.setString('clientPhoneNumber', phoneNumber);
  }

  Future<void> saveClientGradeId(int gradeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientGradeId.value = gradeId;
    prefs.setInt('clientGradeId', gradeId);
  }

  Future<void> saveIsRememberMe(bool isRememberMe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.isRememberMe.value = isRememberMe;
    prefs.setBool('isRememberMe', isRememberMe);
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

  Future<void> deleteClientAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientAccessToken.value = '';
    prefs.remove('clientAccessToken');
  }

  Future<void> deleteClientRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientRefreshToken.value = '';
    prefs.remove('clientRefreshToken');
  }

  Future<void> deleteClientPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientPhoneNumber.value = '';
    prefs.remove('clientPhoneNumber');
  }

  Future<void> deleteClientGradeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clientGradeId.value = -1;
    prefs.remove('clientGradeId');
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

  Future<String?> getClientImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientImageUrl');
  }

  Future<String?> getClientAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientAccessToken');
  }

  Future<String?> getClientRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientRefreshToken');
  }

  Future<String?> getClientPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('clientPhoneNumber');
  }

  Future<int?> getClientGradeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt('clientGradeId');
  }

  Future<bool?> getIsRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isRememberMe');
  }
}
