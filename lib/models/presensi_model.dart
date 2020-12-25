part of 'models.dart';

class PresensiModel {
  PresensiModel({this.code, this.start, this.end, this.uid, this.qrUrl});

  final String code;
  final DateTime end;
  final String qrUrl;
  final DateTime start;
  final String uid;

  PresensiModel copyWith({String code, DateTime start, DateTime end}) {
    return PresensiModel(
        code: code ?? this.code,
        start: start ?? this.start,
        end: end ?? this.end,
        uid: uid,
        qrUrl: qrUrl);
  }
}
