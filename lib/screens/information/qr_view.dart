part of '../screens.dart';

class QrView extends StatefulWidget {
  @override
  _QrViewState createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  Uint8List bytes = Get.arguments[0];
  String code = Get.arguments[1];
  String url = Get.arguments[2];

  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  saveScreen() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      Get.snackbar("Saving QR", "Berhasil di simpan ke gallery");
    } catch (e) {
      Get.snackbar("Saving QR", "Gagal menyimpan ke gallery");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: Warna.white,
        body: SafeArea(
          child: VStack(
            [
              Icon(
                Icons.close_rounded,
                size: 32,
                color: Warna.darkBrown,
              ).objectCenterRight().p20().onTap(() {
                Get.back();
              }),
              VxBox(
                child: bytes.isEmpty ? Image.network(url) : Image.memory(bytes),
              ).makeCentered().wh60(context),
              20.heightBox,
              code.text
                  .textStyle(boldText.copyWith(color: Warna.darkBrown))
                  .xl4
                  .makeCentered(),
              20.heightBox,
              MyButton(
                color: Warna.blue,
                onPress: saveScreen,
                text: "Simpan Ke Gallery",
              ).px16()
            ],
            alignment: MainAxisAlignment.spaceAround,
            crossAlignment: CrossAxisAlignment.center,
          ).scrollVertical().whFull(context),
        ),
      ),
    );
  }
}
