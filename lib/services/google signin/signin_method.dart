import 'package:google_sign_in/google_sign_in.dart';
class GoogleSignInAPI {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();

  static GoogleSignInAccount? check() => _googleSignIn.currentUser;
}








