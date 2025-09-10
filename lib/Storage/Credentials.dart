import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final _storage = GetStorage();

  final _tokenKey = 'access_token';
  final _userKey = 'user';

  // Reactive variables
  RxnString accessToken = RxnString();
  RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  /// Initialize service and load stored values
  Future<AuthService> init() async {
    await GetStorage.init();

    // Load token
    accessToken.value = _storage.read<String>(_tokenKey);

    // Load user data
    final storedUser = _storage.read<Map<String, dynamic>>(_userKey);
    if (storedUser != null) {
      user.assignAll(storedUser);
    }

    return this;
  }

  /// Save login response (user + token) locally
  Future<void> saveLoginData(Map<String, dynamic> responseData) async {
    final token = responseData['access_token'];
    final userData = responseData['user'];

    if (token != null) {
      accessToken.value = token;
      await _storage.write(_tokenKey, token); // ✅ Saves token locally
      print("✅ Token saved locally: $token");
    }

    if (userData != null) {
      user.assignAll(Map<String, dynamic>.from(userData));
      await _storage.write(_userKey, userData); // ✅ Saves user locally
      print("✅ User data saved locally: $userData");
    }
  }

  /// Logout / clear data
  Future<void> clear() async {
    accessToken.value = null;
    user.clear();
    await _storage.remove(_tokenKey);
    await _storage.remove(_userKey);
  }

  /// Helpers
  bool get isLoggedIn => accessToken.value != null;
  String? get avatarUrl => user['avatar'];
  String? get username => user['username'];
  String? get email => user['email'];
}
