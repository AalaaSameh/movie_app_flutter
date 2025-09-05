import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/models/user_request_data.dart';

class FirebaseManager{


  static signUp( {
     required UserData user,
    required String password,
    required Function onError,
    required Function onSuccess,
  } )
  async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
       await credential.user!.sendEmailVerification();
            print("Verification email sent to ${user.email}");
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message?? "");
      } else if (e.code == 'email-already-in-use') {
        onError("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
      onError(e.toString());
    }

  }

}