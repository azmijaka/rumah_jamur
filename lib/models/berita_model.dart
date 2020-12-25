part of 'models.dart';

class BeritaModel {
  BeritaModel(
      {this.code,
      this.judul,
      this.imageUrl,
      this.content,
      this.uid,
      this.nama,
      this.date});

  final String code;
  final String content;
  final DateTime date;
  final String imageUrl;
  final String judul;
  final String nama;
  final String uid;
}
