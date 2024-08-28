import 'package:assignmentjoyistick/utility/uihelper/allpackages.dart';
import 'package:google_sign_in/google_sign_in.dart';

String userName='';
class GoogleSignInService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
           final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await saveUserInfoToSharedPrefs(user);
      }

      return user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  // Save user information to SharedPreferences
  Future<void> saveUserInfoToSharedPrefs(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', user.displayName ?? '');
    await prefs.setString('userEmail', user.email ?? '');
    await prefs.setString('userPhotoUrl', user.photoURL ?? '');
    await prefs.setString('userId', user.uid);
  }


 static Future<Map<String, String?>> getUserInfoFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   print(prefs.getString('userName'));
    userName=prefs.getString('userName')!;
    print(userName);
    return {
      'userName': prefs.getString('userName'),
      'userEmail': prefs.getString('userEmail'),
      'userPhotoUrl': prefs.getString('userPhotoUrl'),
      'userId': prefs.getString('userId'),
    };
  }
}
