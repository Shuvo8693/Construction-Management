
import 'package:charteur/core/config/app_constants.dart';
import 'package:charteur/core/helpers/prefs_helper.dart';

import 'jwt_decoder.dart';

Future<Map<String, dynamic>> getPayloadValue()async{
  final token = await PrefsHelper.getString(AppConstants.bearerToken);

  final payloads = decodeJWT(token);
  String id = payloads['user'] ?? '';
  String role = payloads['role'] ?? '';
  String email = payloads['email'] ?? '';
  bool isLogin = payloads['isLogin'] ?? false;

  return {
    'userId' : id,
    'role' : role,
    'email' : email,
    // 'isLogin' : isLogin,
  };

/// ======= payload response ==========
//   {
//     "header" : {
//   "alg" : "HS256",
//   "typ" : "JWT"
// },
//   "payload" : {
//   "user" : "699ecba8b86b3eb69f46f2c9",
//   "email" : "shuvo52@yopmail.com",
//   "role" : "office_admin",
//   "iat" : 1772014570,
//   "exp" : 1772014750
// },
//   "signature" : "bJJo0L44Ih-ufwLKIaSbAJjb3b4R4sDSbG2_PaY1V30"
// }

}
