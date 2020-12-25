part of 'services.dart';

class BeritaService {
  static CollectionReference beritaCollection =
      FirebaseFirestore.instance.collection('berita');

  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> newBerita(BeritaModel beritaModel) async {
    beritaCollection.doc(beritaModel.code).set({
      'code': beritaModel.code,
      'nama': beritaModel.nama,
      'judul': beritaModel.judul,
      'date': beritaModel.date ?? DateTime.now().millisecondsSinceEpoch,
      'content': beritaModel.content,
      'uid': beritaModel.uid,
      'imageUrl': beritaModel.imageUrl,
    });
  }

  static Future<void> deleteBerita(String code) async {
    beritaCollection.doc(code).delete();
  }
}
