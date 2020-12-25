part of '../screens.dart';

class IzinScreen extends StatefulWidget {
  @override
  _IzinScreenState createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  String code = Get.arguments[1];
  TextEditingController keterangan = TextEditingController();
  UserModel userModel = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VStack(
        [
          SafeArea(
              child: VxBox(
                      child: HStack(
            [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  }),
              'Izin Berhalangan Hadir'
                  .text
                  .textStyle(boldText)
                  .maxLines(1)
                  .makeCentered(),
            ],
          ))
                  .padding(EdgeInsets.symmetric(
                    horizontal: 12,
                  ))
                  .size(context.screenWidth, context.percentHeight * 12)
                  .color(Warna.white)
                  .make()),
          VStack(
            [
              TextFieldKu(
                keterangan: "Keterangan Izin",
                controller: keterangan,
                inputType: TextInputType.text,
              ),
              10.heightBox,
              MyButton(
                color: Warna.red,
                text: 'Izin Sekarang',
                onPress: () async {
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
                  if (!keterangan.text.isEmptyOrNull) {
                    await PresensiService.userIzin(
                            code, userModel, keterangan.text)
                        .then((value) => Get.offAllNamed('/success',
                            arguments: ["izin", userModel, '']));
                  } else {
                    Get.back();
                    Get.snackbar("Error", "Isi keterangan terlebih dahulu");
                  }
                },
              ).objectBottomCenter(),
            ],
            axisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.center,
          ).p16()
        ],
        axisSize: MainAxisSize.max,
        crossAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
