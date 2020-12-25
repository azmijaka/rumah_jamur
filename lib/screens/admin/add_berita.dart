part of '../screens.dart';

class AddBeritaScreen extends StatefulWidget {
  @override
  _AddBeritaScreenState createState() => _AddBeritaScreenState();
}

class _AddBeritaScreenState extends State<AddBeritaScreen> {
  String code;
  TextEditingController contentController = TextEditingController();
  String imageUrl;
  bool isEdit = false;
  TextEditingController judulController = TextEditingController();
  UserModel userModel = Get.arguments;

  @override
  void initState() {
    super.initState();
    code = userModel.uid + DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZStack([
      VStack([
        BackButtonWidget(
          iconData: Icons.arrow_back_ios_outlined,
          title: 'Tambah Berita',
          onPressed: () {
            Get.back();
          },
        ),
        VxBox(
                child: (isEdit)
                    ? CircularProgressIndicator()
                    : (imageUrl.isNullOrBlank)
                        ? Icon(
                            Icons.edit,
                            size: 16,
                            color: Warna.white,
                          )
                        : (fileImage != null)
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.file(
                                  fileImage,
                                  fit: BoxFit.cover,
                                ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      new CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Warna.primary))
                                          .p12(),
                                  errorWidget: (context, url, error) =>
                                      new Icon(
                                    Icons.error_outlined,
                                    color: Warna.white,
                                  ),
                                )))
            .size(context.screenWidth, context.percentWidth * 36)
            .color(Warna.rosyBrown.withOpacity(.5))
            .rounded
            .shadowMd
            .make()
            .p12()
            .onTap(() async {
          await getImage().then((value) async {
            setState(() {
              isEdit = true;
              fileImage = value;
            });
            await uploadImage(code, userModel.uid, value).then((value) {
              setState(() {
                isEdit = false;
                imageUrl = value;
              });
              if (value.isNullOrBlank) {
                Get.snackbar("Error",
                    "Gagal mengunggah gambar, periksa koneksi internet kamu");
              }
              print(value);
            });
          });
        }),
        TextFieldKu(
                keterangan: "Masukkan judul berita",
                controller: judulController,
                inputType: TextInputType.text)
            .px16(),
        10.heightBox,
        TextFieldKu(
          keterangan: "Masukkan isi berita",
          controller: contentController,
          multiLine: true,
          inputType: TextInputType.multiline,
        ).px16(),
      ]).scrollVertical(),
      VxBox(
              child: HStack(
        [
          'Kirim berita '
              .text
              .textStyle(boldText.copyWith(color: Warna.white, fontSize: 12))
              .make(),
          Icon(Icons.send_rounded, color: Warna.white),
        ],
        alignment: MainAxisAlignment.spaceAround,
      ))
          .color(Warna.blue)
          .roundedLg
          .withShadow([
            BoxShadow(
                color: Warna.blue.withOpacity(.3),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(12, 12))
          ])
          .size(context.percentWidth * 52, context.percentHeight * 8)
          .make()
          .onTap(() async {
            Get.dialog(
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Warna.primary),
                  ).centered(),
                ),
                barrierColor: Warna.white.withOpacity(.2),
                barrierDismissible: false,
                transitionCurve: Curves.easeOutQuint);

            if (!judulController.text.isNullOrBlank ||
                !contentController.text.isNullOrBlank ||
                imageUrl.isNullOrBlank) {
              await BeritaService.newBerita(BeritaModel(
                      code: code,
                      judul: judulController.text,
                      imageUrl: imageUrl,
                      content: contentController.text,
                      uid: userModel.uid,
                      nama: userModel.nama,
                      date: DateTime.now()))
                  .then((value) {
                Get.back();
                Get.offAllNamed(
                  '/home',
                );
              });
            }
          })
          .objectBottomCenter()
          .marginOnly(bottom: 40)
    ]));
  }
}
