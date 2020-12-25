part of 'services.dart';

class AuthServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<Result> createUserWithEmailAndPassword(
      String email, String password, UserModel userModel) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel user = userCredential.user.convertToUser(
        email: email,
        nama: userModel.nama,
        nim: userModel.nim,
        photoUrl: userModel.photoUrl,
      );

      await UserServices.setUser(user);
      return Result(userModel: userCredential.user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return Result(message: e.toString().split('/')[1].split(']')[1].trim());
    }
  }

  static Future<Result> signInEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Result(userModel: userCredential.user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return Result(
          message: e.toString().split('/')[1].split(']')[1].trim(),
          userModel: null);
    }
  }

  static Future resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Stream<User> get userStream =>
      auth.authStateChanges().asBroadcastStream();
}

class Result {
  Result({this.userModel, this.message});

  final String message;
  final User userModel;
}
