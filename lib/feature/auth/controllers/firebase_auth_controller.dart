// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'dart:convert';
// import 'dart:math';
// import 'package:crypto/crypto.dart';
//
// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Google Sign-In instance — scopes নিশ্চিত করা হয়েছে
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//   );
//
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//   User? get currentUser => _auth.currentUser;
//
//   // ─────────────────────────────────────────────
//   // GOOGLE SIGN-IN
//   // ─────────────────────────────────────────────
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       // আগের session থাকলে clear করো
//       await _googleSignIn.signOut();
//
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;
//
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;
//
//       // accessToken এবং idToken null হলে error
//       if (googleAuth.accessToken == null || googleAuth.idToken == null) {
//         throw Exception(
//             'Tokens null — SHA1 Firebase Console এ add করা আছে কিনা চেক করুন।');
//       }
//
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       return await _auth.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw _handleFirebaseAuthException(e);
//     } catch (e) {
//       throw Exception('Google Sign-In failed: $e');
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   // APPLE SIGN-IN
//   // ─────────────────────────────────────────────
//   String _generateNonce([int length = 32]) {
//     const charset =
//         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//         .join();
//   }
//
//   String _sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }
//
//   Future<UserCredential?> signInWithApple() async {
//     try {
//       final rawNonce = _generateNonce();
//       final nonce = _sha256ofString(rawNonce);
//
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         nonce: nonce,
//       );
//
//       final oauthCredential = OAuthProvider('apple.com').credential(
//         idToken: appleCredential.identityToken,
//         rawNonce: rawNonce,
//       );
//
//       final userCredential = await _auth.signInWithCredential(oauthCredential);
//
//       final fullName = appleCredential.givenName != null
//           ? '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
//           .trim()
//           : null;
//
//       if (fullName != null && fullName.isNotEmpty) {
//         await userCredential.user?.updateDisplayName(fullName);
//       }
//
//       return userCredential;
//     } on SignInWithAppleAuthorizationException catch (e) {
//       if (e.code == AuthorizationErrorCode.canceled) return null;
//       throw Exception('Apple Sign-In failed: ${e.message}');
//     } on FirebaseAuthException catch (e) {
//       throw _handleFirebaseAuthException(e);
//     } catch (e) {
//       throw Exception('Apple Sign-In failed: $e');
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   // SIGN OUT
//   // ─────────────────────────────────────────────
//   Future<void> signOut() async {
//     await Future.wait([
//       _auth.signOut(),
//       _googleSignIn.signOut(),
//     ]);
//   }
//
//   // ─────────────────────────────────────────────
//   // ERROR HANDLER
//   // ─────────────────────────────────────────────
//   Exception _handleFirebaseAuthException(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'account-exists-with-different-credential':
//         return Exception('এই email দিয়ে অন্য method এ account আছে।');
//       case 'invalid-credential':
//         return Exception('Invalid credentials. আবার try করুন।');
//       case 'user-disabled':
//         return Exception('এই account disabled করা হয়েছে।');
//       case 'user-not-found':
//         return Exception('User পাওয়া যায়নি।');
//       case 'network-request-failed':
//         return Exception('Network error. Internet connection চেক করুন।');
//       default:
//         return Exception('Authentication failed: ${e.message}');
//     }
//   }
// }