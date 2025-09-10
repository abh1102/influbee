class ApiConfig {
  // static const String baseUrl = "https://707bbf47b4b6.ngrok-free.app/api";
  static const String baseUrl ="http://13.203.14.80:3001/api";
  static const String login = "$baseUrl/auth/login";
  static const String ForgetPassword = "$baseUrl/auth/forgot-password";
  static const String SignUp = "$baseUrl/auth/register_influencer";

  static const String UserList = "$baseUrl/chat/users/available";
  static  String GetPersonalMessages(String partnerId) {
    return '$baseUrl/chat/personal/messages/$partnerId';
  }
  static const String SendPersonalMessage= "$baseUrl/chat/personal/messages";


}