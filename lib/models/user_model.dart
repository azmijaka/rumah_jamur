part of 'models.dart';

class UserModel {
  UserModel(
      {this.uid,
      this.email,
      this.nama,
      this.nim,
      this.photoUrl,
      this.noTelephone,
      this.role});

  final String email;
  final String nama;
  final String nim;
  final String noTelephone;
  final String photoUrl;
  final String role;
  final String uid;

  UserModel copyWith(
      {String uid,
      String nama,
      String nim,
      String email,
      String photoUrl,
      String noTelephone,
      String role}) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      nama: nama ?? this.nama,
      nim: nim ?? this.nim,
      photoUrl: photoUrl ?? this.photoUrl,
      noTelephone: noTelephone ?? this.noTelephone,
      role: role ?? this.role,
    );
  }
}
