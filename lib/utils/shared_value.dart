part of 'utils.dart';

mixin Warna {
  // Mixins dalam Dart bekerja dengan membuat kelas baru yang melapisi implementasi
  // dari mixin di atas superclass untuk membuat kelas baru - ini bukan "di samping"
  // tetapi "di atas" superclass, jadi tidak ada ambiguitas dalam cara menyelesaikan pencarian.
  static Color primary = Color(0xFFd1a17b);
  static Color red = Color(0xFFff7f50);
  static Color blue = Color(0xFF70a1ff);
  static Color green = Color(0xFF7bed9f);
  static Color white = Color(0xFFffffff);
  static Color accent = Color(0xFFbb977d);
  static Color gray = Color(0xFF878076);
  static Color rosyBrown = Color(0xFFaa9e92);
  static Color gainsboro = Color(0xFFe8e3d9);
  static Color lynxWhite = Color(0xFFf5f6fa);
  static Color darkBrown = Color(0xFF3d3d3d);
}

String sharedID = '';

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Pagi';
  }
  if (hour < 17) {
    return 'Sore';
  }
  return 'Malam';
}

TextStyle primaryText = TextStyle(
  fontFamily: "Montserrat",
  color: Warna.darkBrown,
  fontSize: 14,
);

TextStyle italicText = TextStyle(
  fontFamily: "Montserrat",
  color: Warna.darkBrown,
  fontStyle: FontStyle.italic,
  fontSize: 14,
);

TextStyle boldText = TextStyle(
  fontFamily: "Montserrat",
  color: Warna.darkBrown,
  fontWeight: FontWeight.w700,
  fontSize: 14,
);

TextStyle lightText = TextStyle(
  fontFamily: "Montserrat",
  color: Warna.darkBrown,
  fontWeight: FontWeight.w200,
  fontSize: 14,
);

final box = GetStorage();
File fileImage;
final imagePicker = ImagePicker();
